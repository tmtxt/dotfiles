# Script to trigger CW1 test using dotnet test from Jetbrains Rider
param (
  [string]$FilePath,
  [int]$LineNumber
)

Push-Location $PSScriptRoot
$projectPath = & dotnet run ".\ProjectFinder.cs" $FilePath csproj
$methodName = & dotnet run ".\MethodFinder.cs" -- $FilePath $LineNumber FullyQualifiedName
Pop-Location

Write-Output "Running unit test using dotnet test..."
Write-Output "Project: $projectPath"
Write-Output "Method: $methodName"
Write-Output ""

Push-Location "C:\git\GitHub\WiseTechGlobal\CargoWise"
dotnet test $projectPath --filter "FullyQualifiedName~$methodName&CapabilityRequirements~NET48"
Pop-Location