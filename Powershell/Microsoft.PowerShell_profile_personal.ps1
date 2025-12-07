# Detect the actual profile folder
$hardLinks = @(& fsutil hardlink list $PSCommandPath 2>$null | Where-Object { $_.Trim() -ne '' })
$profilePath = if ($hardLinks.Count -gt 1) { $hardLinks[1] } else { $hardLinks[0] }
$profileFolder = Split-Path -Parent $profilePath
Write-Host "Using profile: $profileFolder";

Import-Module ZLocation

# Imports
try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }

# path
$env:Path = "$(scoop prefix msys2)\usr\bin;" + $env:Path
$env:Path = "$(scoop prefix msys2)\mingw64\bin;" + $env:Path

# Scripts
. "$profileFolder\Scripts\Utils\Config.ps1"
. "$profileFolder\Scripts\Utils\DevUtils.ps1"

# Personal utils
Function Download-YoutubeMp3 {
    if (!$args[0]) {
        Throw "Usage: Download-YoutubeMp3 $url"
    }

    $url = $args[0]

    youtube-dl.exe $url -x --audio-format mp3 --audio-quality 0 --prefer-ffmpeg
}
