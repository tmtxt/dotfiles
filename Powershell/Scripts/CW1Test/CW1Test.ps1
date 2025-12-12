# Script to trigger CW1 from Jetbrains Rider
param (
  [string]$FilePath,
  [int]$LineNumber
)

Push-Location $PSScriptRoot
$projectPath = & dotnet run ".\ProjectFinder.cs" $FilePath
$methodName = & dotnet run ".\MethodFinder.cs" -- $FilePath $LineNumber FullyQualifiedName
Pop-Location

Write-Output "Running unit test..."
Write-Output "Project: $projectPath"
Write-Output "Method: $methodName"
Write-Output ""

Push-Location "C:\git\GitHub\WiseTechGlobal\CargoWise"
dotnet test $projectPath --filter "FullyQualifiedName~$methodName&CapabilityRequirements~NET48"
Pop-Location