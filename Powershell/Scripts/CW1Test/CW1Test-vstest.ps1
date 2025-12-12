# Script to trigger CW1 test using vstest.console.exe from Jetbrains Rider
param (
  [string]$FilePath,
  [int]$LineNumber
)

Push-Location $PSScriptRoot
$projectPath = & dotnet run ".\ProjectFinder.cs" $FilePath dll
$methodName = & dotnet run ".\MethodFinder.cs" -- $FilePath $LineNumber NameOnly
Pop-Location

Write-Output "Running unit test using vstest.console.exe..."
Write-Output "Project: $projectPath"
Write-Output "Method: $methodName"
Write-Output ""

Push-Location "C:\git\GitHub\WiseTechGlobal\CargoWise\Bin"
& 'C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe' $projectPath /Tests:$methodName
Pop-Location