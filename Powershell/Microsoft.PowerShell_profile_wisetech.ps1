Set-Alias -Name ll -Value Get-ChildItem -Option AllScope
Set-Alias -Name which -Value Get-Command -Option AllScope
Set-Alias -Name open -Value Invoke-Item -Option AllScope

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/minimal.omp.json" | Invoke-Expression

Import-Module ZLocation
Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"
Set-Alias -Name j -Value Invoke-ZLocation

Function uuidv4 {
    (New-Guid).Guid.ToUpper() | Set-Clipboard
    Write-Output "New uuidv4 (upper-case) copied to clipboard"
}

Function uuidv4Lower {
    (New-Guid).Guid | Set-Clipboard
    Write-Output "New uuidv4 (lower-case) copied to clipboard"
}

function randomstring {
    param (
        [int]$length = 10
    )

    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    $random = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count $length | ForEach-Object { [char]$_ })
    $random | Set-Clipboard
    return $random
}