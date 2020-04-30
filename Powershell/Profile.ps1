# aliases
Set-Alias -Name ll -Value Get-ChildItem

# util functions
Function Download-YoutubeMp3 {
    if (!$args[0])
    {
        Throw "Usage: Download-YoutubeMp3 $url"
    }

    $url = $args[0]

     youtube-dl.exe $url -x --audio-format mp3 --audio-quality 0 --prefer-ffmpeg
}
