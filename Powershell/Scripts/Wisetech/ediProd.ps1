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

function CopyWorkitemLink {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory, Position = 0)]
		[string]$workitemId
	)

	if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
		Write-Error "fzf is not installed. Install with: winget install junegunn.fzf"
		return
	}

	# edi emits UTF-8; without this, non-ASCII link names are garbled
	$previousEncoding = [Console]::OutputEncoding
	[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

	try {
		# Description is independent of the workflow/task chain, so fetch it concurrently
		$descriptionJob = Start-ThreadJob -ScriptBlock {
			edi --format jsonl --fields description workitem get $using:workitemId
		}

		$workflowIds = @(edi --format jsonl --fields workflowId workflow list $workitemId |
			ConvertFrom-Json | ForEach-Object { $_.workflowId })

		$taskIds = @($workflowIds | ForEach-Object -Parallel {
				edi --format jsonl --fields id task list $_ | ConvertFrom-Json | ForEach-Object { $_.id }
			} -ThrottleLimit 8)

		$notes = @($taskIds | ForEach-Object -Parallel {
				(edi task notes read $_) -join "`n"
			} -ThrottleLimit 8)

		$descriptionJson = (Receive-Job -Job $descriptionJob -Wait -AutoRemoveJob) -join "`n"
		$description = if ($descriptionJson) { ($descriptionJson | ConvertFrom-Json).description } else { $null }

		$links = @(Get-MarkdownLinks $description) + @($notes | ForEach-Object { Get-HtmlLinks $_ })
	}
	finally {
		[Console]::OutputEncoding = $previousEncoding
	}

	$seen = [System.Collections.Generic.HashSet[string]]::new()
	$links = @($links | Where-Object { $seen.Add($_.Url) })
	if ($links.Count -eq 0) {
		Write-Warning "No links found in $workitemId."
		return
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
