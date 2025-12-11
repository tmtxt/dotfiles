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