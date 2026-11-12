#Requires -Version 7.0

if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
	Write-Warning "fzf is not installed. CopyWorkitemLink needs it. Install with: winget install junegunn.fzf"
}

function Get-MarkdownLinks {
	param([string]$Text)

	if (-not $Text) { return }

	$linkPattern = '\[([^\]]*)\]\((https?://[^)\s]+)\)'
	foreach ($m in [regex]::Matches($Text, $linkPattern)) {
		[pscustomobject]@{ Name = $m.Groups[1].Value; Url = $m.Groups[2].Value }
	}

	# Bare URLs are whatever remains once the markdown links are removed
	$remaining = [regex]::Replace($Text, $linkPattern, '')
	foreach ($m in [regex]::Matches($remaining, 'https?://[^\s)\]>"''<]+')) {
		$url = $m.Value.TrimEnd('.', ',', ';', ':')
		[pscustomobject]@{ Name = $url; Url = $url }
	}
}

function Get-HtmlLinks {
	param([string]$Html)

	if (-not $Html) { return }

	$options = [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline
	foreach ($m in [regex]::Matches($Html, '<a\s[^>]*?href\s*=\s*"([^"]*)"[^>]*>(.*?)</a>', $options)) {
		$url = [System.Net.WebUtility]::HtmlDecode($m.Groups[1].Value).Trim()
		if ($url -notmatch '^https?://') { continue }

		$name = [System.Net.WebUtility]::HtmlDecode(([regex]::Replace($m.Groups[2].Value, '<[^>]+>', '')))
		[pscustomobject]@{ Name = $name; Url = $url }
	}
}

function Get-WorkitemLinks {
	param([string]$workitemId)

	# edi emits UTF-8; without this, non-ASCII link names are garbled
	$previousEncoding = [Console]::OutputEncoding
	[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

	try {
		# Description is independent of the workflow/task chain, so fetch it concurrently
		Write-Host "Fetching description of $workitemId..." -ForegroundColor DarkGray
		$descriptionJob = Start-ThreadJob -ScriptBlock {
			edi --format jsonl --fields description workitem get $using:workitemId
		}

		Write-Host "Listing workflows of $workitemId..." -ForegroundColor DarkGray
		$workflowIds = @(edi --format jsonl --fields workflowId workflow list $workitemId |
			ConvertFrom-Json | ForEach-Object { $_.workflowId })

		Write-Host "Listing tasks of $($workflowIds.Count) workflows..." -ForegroundColor DarkGray
		$taskIds = @($workflowIds | ForEach-Object -Parallel {
				edi --format jsonl --fields id task list $_ | ConvertFrom-Json | ForEach-Object { $_.id }
			} -ThrottleLimit 8)

		Write-Host "Reading notes of $($taskIds.Count) tasks..." -ForegroundColor DarkGray
		$notes = @($taskIds | ForEach-Object -Parallel {
				(edi task notes read $_) -join "`n"
			} -ThrottleLimit 8)

		Write-Host "Waiting for description..." -ForegroundColor DarkGray
		$descriptionJson = (Receive-Job -Job $descriptionJob -Wait -AutoRemoveJob) -join "`n"
		$description = if ($descriptionJson) { ($descriptionJson | ConvertFrom-Json).description } else { $null }

		$links = @(Get-MarkdownLinks $description) + @($notes | ForEach-Object { Get-HtmlLinks $_ })
	}
	finally {
		[Console]::OutputEncoding = $previousEncoding
	}

	$seen = [System.Collections.Generic.HashSet[string]]::new()
	@($links | Where-Object { $seen.Add($_.Url) })
}

function CopyWorkitemLink {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory, Position = 0)]
		[ValidatePattern('^[A-Za-z0-9_-]+$')]
		[string]$workitemId,

		[switch]$Refresh
	)

	if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
		Write-Error "fzf is not installed. Install with: winget install junegunn.fzf"
		return
	}

	$workitemId = $workitemId.ToUpperInvariant()
	$cacheFile = Join-Path (Join-Path $env:LOCALAPPDATA 'ediProd-cache') "$workitemId.json"
	$cacheTtl = [timespan]::FromDays(1)

	$links = $null
	if (-not $Refresh -and (Test-Path $cacheFile)) {
		$age = (Get-Date) - (Get-Item $cacheFile).LastWriteTime
		if ($age -lt $cacheTtl) {
			try {
				$links = @(Get-Content $cacheFile -Raw | ConvertFrom-Json)
				Write-Host ("Using cached links ({0:N0}m old). Use -Refresh to reload." -f $age.TotalMinutes)
			}
			catch {
				$links = $null
			}
		}
	}

	if (-not $links) {
		$links = Get-WorkitemLinks $workitemId
		if ($links.Count -eq 0) {
			Write-Warning "No links found in $workitemId."
			return
		}

		New-Item -ItemType Directory -Path (Split-Path $cacheFile) -Force | Out-Null
		ConvertTo-Json -InputObject @($links) | Set-Content -Path $cacheFile -Encoding utf8
	}

	$lines = $links | ForEach-Object {
		$name = ([regex]::Replace($_.Name, '\s+', ' ')).Trim()
		if (-not $name) { $name = $_.Url }
		"$name`t$($_.Url)"
	}

	# Re-show the picker after each selection; Esc (empty selection) exits
	while ($true) {
		$selected = $lines | fzf --delimiter "`t" --prompt "$workitemId link> "
		if (-not $selected) { return }

		$url = ($selected -split "`t")[-1]
		Set-Clipboard -Value $url
		Write-Host "Copied: $url"
		Start-Process $url
	}
}

Export-ModuleMember -Function CopyWorkitemLink
