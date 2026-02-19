function BuildDbUpgrader {
  & 'C:\Program Files (x86)\WiseTech Global\CrikeyMonitor\QGL\QuickGetLatest.exe' -GitTarget:c:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader -BuildAll
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
