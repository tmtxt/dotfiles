# Script to trigger CW1 test using dotnet test from Jetbrains Rider
param (
  [string]$FilePath,
  [int]$LineNumber
)

Push-Location $PSScriptRoot
$output = & dotnet run ".\CW1TestHelper.cs" -- $FilePath $LineNumber
Pop-Location

# Parse output
$projectPath = ""
$methodName = ""
foreach ($line in $output) {
  if ($line.StartsWith("PROJECT_PATH:")) {
    $projectPath = $line.Substring("PROJECT_PATH:".Length)
  }
  elseif ($line.StartsWith("METHOD_NAME:")) {
    $methodName = $line.Substring("METHOD_NAME:".Length)
  }
}

Write-Output "Running unit test using dotnet test..."
Write-Output "Project: $projectPath"
Write-Output "Method: $methodName"
Write-Output ""

Push-Location "C:\git\GitHub\WiseTechGlobal\CargoWise"
dotnet test $projectPath --filter "FullyQualifiedName~$methodName&CapabilityRequirements~NET48"
Pop-Location