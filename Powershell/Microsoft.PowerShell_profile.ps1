# Imports

try { $null = gcm pshazz -ea stop; pshazz init 'default' } catch { }

# path
$env:Path = "$(scoop prefix msys2)\usr\bin;" + $env:Path
$env:Path = "$(scoop prefix msys2)\mingw64\bin;" + $env:Path

# aliases
Set-Alias -Name ll -Value Get-ChildItem -Option AllScope

# util functions
Function Download-YoutubeMp3 {
    if (!$args[0])
    {
        Throw "Usage: Download-YoutubeMp3 $url"
    }

    $url = $args[0]

    youtube-dl.exe $url -x --audio-format mp3 --audio-quality 0 --prefer-ffmpeg
}

# docker alias
Function dcu {
    docker-compose up
}
Function dcud {
    docker-compose up -d
}
Function dcp {
    docker-compose ps
}
Function dcl {
    docker-compose logs -f
}
Function dck {
    docker-compose kill
}

# autojump
Import-Module ZLocation
Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"
Set-Alias -Name j -Value Invoke-ZLocation
