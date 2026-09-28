function BuildDbUpgrader {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader -BuildAll
}

function BuildCW1Master {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\CargoWise -GitCheckoutBranch:master -GitPullFromOrigin:master -BuildAll -BinariesCache:ArtifactRepository
}

function BuildRefDataRepo {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\RefDataRepo -BuildAll
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
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\Enterprise.DbUpgrader.Resource.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\Enterprise.DbUpgrader.Resource.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.Odyssey.Schema.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.Odyssey.Schema.pdb" -Force

  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\Enterprise.DbUpgrader.Resource.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\Enterprise.DbUpgrader.Resource.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.Odyssey.Schema.dll" -Force
  Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.Odyssey.Schema.pdb" -Force
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