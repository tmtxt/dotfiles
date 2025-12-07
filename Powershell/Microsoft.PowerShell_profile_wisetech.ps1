# Detect the actual profile folder
$hardLinks = @(& fsutil hardlink list $PSCommandPath 2>$null | Where-Object { $_.Trim() -ne '' })
$profilePath = if ($hardLinks.Count -gt 1) { $hardLinks[1] } else { $hardLinks[0] }
$profileFolder = Split-Path -Parent $profilePath
Write-Host "Using profile: $profileFolder";

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/minimal.omp.json" | Invoke-Expression
Import-Module ZLocation

# Specific to work laptop
$env:Path += ";C:\Users\tony.tran\AppData\Roaming\npm"
$env:Path = "C:\Users\Tony.Tran\.local\bin;$env:Path"

# Scripts
. "$profileFolder\Scripts\Utils\Config.ps1"
. "$profileFolder\Scripts\Utils\DevUtils.ps1"
. "$profileFolder\Scripts\Wisetech\CW1Utils.ps1"