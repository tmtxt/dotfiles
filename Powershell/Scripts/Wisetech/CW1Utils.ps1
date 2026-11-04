function BuildDbUpgrader {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader -BuildAll
}

function BuildCargoWiseDatabase {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database -BuildAll
}

function BuildCW1Master {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\CargoWise -GitCheckoutBranch:master -GitPullFromOrigin:master -BuildAll -BinariesCache:ArtifactRepository
}

function BuildRefDataRepo {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\RefDataRepo -BuildAll
}

function BuildCargoWiseCustomsVN {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\CargoWise.Customs\VN -BuildAll
}

function PullMasterCustomsRepo {
  Set-Location "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared"
  git checkout master
  git pull origin master

  Set-Location "C:\git\GitHub\WiseTechGlobal\CargoWise.Customs"
  git checkout master
  git pull origin master

  Set-Location "C:\git\GitHub\WiseTechGlobal\Customs.Specifications"
  git checkout main
  git pull origin main

  Set-Location "C:\git\GitHub\WiseTechGlobal\Customs.Content"
  git checkout main
  git pull origin main
}

function CopyDbUpgrader {
  # CargoWise/Bin
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\Enterprise.DbUpgrader.Resource.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\Enterprise.DbUpgrader.Resource.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.Odyssey.Schema.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.Odyssey.Schema.pdb" -Force

  # CargoWise/Bin/net10.0
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net10.0\Enterprise.DbUpgrader.Resource.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net10.0\Enterprise.DbUpgrader.Resource.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net10.0\CargoWise.Odyssey.Schema.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net10.0\CargoWise.Odyssey.Schema.pdb" -Force

  # CargoWise.Database/Database/Bin/net48
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net48\Enterprise.DbUpgrader.Resource.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net48\Enterprise.DbUpgrader.Resource.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net48\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net48\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net48\CargoWise.Odyssey.Schema.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net48\CargoWise.Odyssey.Schema.pdb" -Force

  # CargoWise.Database/Database/Bin/net10.0
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net10.0\Enterprise.DbUpgrader.Resource.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net10.0\Enterprise.DbUpgrader.Resource.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net10.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net10.0\CargoWise.Odyssey.Schema.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net10.0\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise.Database\Database\Bin\net10.0\CargoWise.Odyssey.Schema.pdb" -Force
}

function CheckoutCW1Branch {
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$branchName
  )

  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:/git/GitHub/WiseTechGlobal/CargoWise/ -GitCheckoutBranch:$branchName -NoBuild
}

function DecreaseCW1DatabaseVersion {
  param (
    [Parameter(Mandatory = $true)]
    [string]$database
  )

  # Configuration
  $serverInstance = "localhost"

  # Query to read the current value
  $selectQuery = @"
SELECT TOP 1
    CONVERT(nvarchar(4000), CONVERT(varbinary(8000), SD_BinaryValue)) AS BinaryValueAsString
FROM StmData
WHERE SD_Name = 'DATABASE_SCHEMA_VERSION'
"@

  try {
    # Read current value
    $result = Invoke-Sqlcmd -ServerInstance $serverInstance -Database $database -Query $selectQuery -ErrorAction Stop

    if ($null -eq $result) {
      Write-Error "No rows found in StmData table"
      exit 1
    }

    # Parse to integer and decrement
    $currentValue = [int]$result.BinaryValueAsString
    $newValue = $currentValue - 1

    Write-Host "Current value: $currentValue"
    Write-Host "New value: $newValue"

    # Update query
    $updateQuery = @"
UPDATE StmData
SET SD_BinaryValue = Convert(image, convert(varbinary(8000), N'$newValue'))
WHERE SD_Name = 'DATABASE_SCHEMA_VERSION'
"@

    # Execute update
    Invoke-Sqlcmd -ServerInstance $serverInstance -Database $database -Query $updateQuery -ErrorAction Stop

    Write-Host "Successfully updated value to $newValue"
  }
  catch {
    Write-Error "An error occurred: $_"
    exit 1
  }
}

function DecreaseOdysseyVersion {
  DecreaseCW1DatabaseVersion -database "Odyssey"
}

function DecreaseOdysseyTrainingModelVersion {
  DecreaseCW1DatabaseVersion -database "OdysseyTrainingModel"
}

function KillDotnetProcesses {
  $processes = Get-Process -Name dotnet -ErrorAction SilentlyContinue
  if ($processes) {
    $processes | Stop-Process -Force
    Write-Host ("Killed {0} .NET Host process(es)" -f $processes.Count)
  }
  else {
    Write-Host "No .NET Host processes found"
  }
}

function KillNodeProcesses {
  $processes = Get-Process -Name node -ErrorAction SilentlyContinue
  if ($processes) {
    $processes | Stop-Process -Force
    Write-Host ("Killed {0} Node.js process(es)" -f $processes.Count)
  }
  else {
    Write-Host "No Node.js processes found"
  }
}

function RenameRefDatabase {
  $serverInstance = "localhost"
  $baseName = "CW-RefDatabase"
  $fullName = "$baseName-Full"
  $emptyName = "$baseName-Empty"

  $listQuery = "SELECT name FROM sys.databases WHERE name LIKE '$baseName%' ORDER BY name"
  $databases = Invoke-Sqlcmd -ServerInstance $serverInstance -Database "master" -Query $listQuery -ErrorAction Stop | Select-Object -ExpandProperty name

  Write-Host "Databases found matching '$baseName*':"
  $databases | ForEach-Object { Write-Host " - $_" }

  $hasBase = $databases -contains $baseName
  $hasFull = $databases -contains $fullName
  $hasEmpty = $databases -contains $emptyName

  # Rename the plain-named DB first to free up $baseName for the other one
  if ($hasBase -and $hasFull -and -not $hasEmpty) {
    $renameSteps = @(
      @{ Old = $baseName; New = $emptyName },
      @{ Old = $fullName; New = $baseName }
    )
  }
  elseif ($hasBase -and $hasEmpty -and -not $hasFull) {
    $renameSteps = @(
      @{ Old = $baseName; New = $fullName },
      @{ Old = $emptyName; New = $baseName }
    )
  }
  else {
    Write-Error "Unexpected database state - requires human intervention. Expected exactly '$baseName' plus one of '$fullName'/'$emptyName'. Found: $($databases -join ', ')"
    return
  }

  Write-Host "`nThe following renames will be performed:"
  foreach ($step in $renameSteps) {
    Write-Host "  '$($step.Old)' -> '$($step.New)'"
  }

  $confirmation = Read-Host "`nPress Enter to confirm, or type anything else to cancel"
  if ($confirmation -ne '') {
    Write-Host "Cancelled."
    return
  }

  foreach ($step in $renameSteps) {
    $renameQuery = "ALTER DATABASE [$($step.Old)] MODIFY NAME = [$($step.New)]"
    Invoke-Sqlcmd -ServerInstance $serverInstance -Database "master" -Query $renameQuery -ErrorAction Stop
    Write-Host "Renamed '$($step.Old)' -> '$($step.New)'"
  }

  Write-Host "Done."
}

function BuildNoDepsCargoWiseGitBranch {
  param (
    [string]$CargoWiseRepoPath = "c:\git\GitHub\WiseTechGlobal\CargoWise",
    [bool]$IncludeWinzorProjects = $false
  )

  # Native stderr (e.g. git info output) must not become a terminating error under EAP='Stop'
  function Invoke-Git {
    param ([string[]]$GitArgs)
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
      $output = & git -C $CargoWiseRepoPath @GitArgs 2>&1
      $exitCode = $LASTEXITCODE
    }
    finally {
      $ErrorActionPreference = $previousPreference
    }
    if ($exitCode -ne 0) {
      throw "git $($GitArgs -join ' ') failed (exit $exitCode): $($output -join "`n")"
    }
    return @($output | ForEach-Object { "$_" })
  }

  if (-not (Test-Path -LiteralPath $CargoWiseRepoPath)) {
    throw "Repo path not found: $CargoWiseRepoPath"
  }

  $currentBranch = (Invoke-Git @('rev-parse', '--abbrev-ref', 'HEAD') | Select-Object -First 1).Trim()
  if ($currentBranch -eq 'master') {
    throw "Current branch is 'master'. Switch to a feature branch first."
  }

  $repoRoot = (Invoke-Git @('rev-parse', '--show-toplevel') | Select-Object -First 1).Trim()
  $repoRoot = [System.IO.Path]::GetFullPath($repoRoot)

  # Three-dot diff: only changes made on this branch since it diverged from master
  $changedFiles = Invoke-Git @('diff', '--name-only', 'master...HEAD') | Where-Object { $_ }

  $projects = [System.Collections.Generic.List[string]]::new()
  foreach ($file in $changedFiles) {
    $dir = Split-Path -Parent ([System.IO.Path]::GetFullPath((Join-Path $repoRoot $file)))

    # Deleted files may have no directory anymore; keep walking up until we find one
    while ($dir -and $dir.Length -ge $repoRoot.Length) {
      if (Test-Path -LiteralPath $dir -PathType Container) {
        $csprojFiles = @(Get-ChildItem -LiteralPath $dir -Filter '*.csproj' -File)
        if ($csprojFiles.Count -gt 0) {
          foreach ($csproj in $csprojFiles) {
            $isWinzor = $csproj.Name -like '*.Winzor.csproj'
            if ($isWinzor -and -not $IncludeWinzorProjects) { continue }
            if (-not $projects.Contains($csproj.FullName)) { $projects.Add($csproj.FullName) }
          }
          break
        }
      }
      $dir = Split-Path -Parent $dir
    }
  }

  if ($projects.Count -eq 0) {
    Write-Host "No affected .csproj files found on branch '$currentBranch'."
    return
  }

  $waiting = [System.Collections.Generic.List[string]]::new($projects)
  $built = [System.Collections.Generic.List[string]]::new()

  function Format-Project {
    param ([string]$Path)
    '{0} ({1})' -f (Split-Path -Leaf $Path), (Split-Path -Parent $Path)
  }

  while ($waiting.Count -gt 0) {
    Write-Host "`nBuilt:" -ForegroundColor Green
    if ($built.Count -eq 0) { Write-Host "  (none)" }
    foreach ($item in $built) { Write-Host "  [done] $(Format-Project $item)" -ForegroundColor Green }

    Write-Host "`nWaiting to build:" -ForegroundColor Yellow
    for ($i = 0; $i -lt $waiting.Count; $i++) {
      Write-Host ("  {0}. {1}" -f ($i + 1), (Format-Project $waiting[$i]))
    }

    $choice = Read-Host "`nChoose a project to build (1-$($waiting.Count)), or 'q' to quit"
    if ($choice -eq 'q') { return }

    $index = 0
    if (-not [int]::TryParse($choice, [ref]$index) -or $index -lt 1 -or $index -gt $waiting.Count) {
      Write-Host "Invalid choice: '$choice'" -ForegroundColor Red
      continue
    }

    $csprojFile = $waiting[$index - 1]
    Push-Location (Split-Path -Parent $csprojFile)
    try {
      dotnet build $csprojFile --configuration Debug --no-dependencies /p:ProduceReferenceAssembly=false
      $buildSucceeded = ($LASTEXITCODE -eq 0)
    }
    finally {
      Pop-Location
    }

    if ($buildSucceeded) {
      $waiting.RemoveAt($index - 1)
      $built.Add($csprojFile)
    }
    else {
      Write-Host "Build failed for $csprojFile; it stays in the waiting list." -ForegroundColor Red
    }
  }

  Write-Host "`nAll projects built:" -ForegroundColor Green
  foreach ($item in $built) { Write-Host "  [done] $(Format-Project $item)" -ForegroundColor Green }
}
