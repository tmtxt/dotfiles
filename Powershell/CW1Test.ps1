param (
  [string]$FilePath,
  [int]$LineNumber
)

# dotnet --list-sdks

# Write-Host $FilePath
# Write-Host $LineNumber

# Run first sub-command (e.g., ProjectFinder)
Push-Location $PSScriptRoot
$projectPath = & dotnet run "C:\projects\dotfiles\Powershell\ProjectFinder.cs" $FilePath

# Run second sub-command (e.g., MethodFinder)
$methodName = & dotnet run "C:\projects\dotfiles\Powershell\MethodFinder.cs" -- $FilePath $LineNumber
Pop-Location

# Use both outputs in another command (example: echo)
Write-Output "Project: $projectPath"
Write-Output "Method: $methodName"
Write-Output ""
# Write-Output "Combined: $projectPath :: $methodName"
Push-Location "C:\git\GitHub\WiseTechGlobal\CargoWise"
dotnet test $projectPath --filter "FullyQualifiedName~$methodName&CapabilityRequirements~NET48"
Pop-Location