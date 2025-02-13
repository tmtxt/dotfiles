Set-Alias -Name ll -Value Get-ChildItem -Option AllScope
Set-Alias -Name which -Value Get-Command -Option AllScope
Set-Alias -Name open -Value Invoke-Item -Option AllScope

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/minimal.omp.json" | Invoke-Expression

Import-Module ZLocation
# Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"
Set-Alias -Name j -Value Invoke-ZLocation

function Read-MultiLineInput {
    $inputLines = @()
    $endMarker = ""
    Write-Host "Enter multiple lines of input (type 'Ctrl+D and then Enter' on a new line to finish):"

    while ($true) {
        $line = Read-Host
        if ($line -eq $endMarker) {
            break
        }
        $inputLines += $line
    }

    return $inputLines -join "`n"
}

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

function lowercase {
    Write-Host "Please enter the string to convert to lowercase and copy to clipboard:"
    $InputString = Read-Host
    $lowerCaseString = $InputString.ToLower()
    $lowerCaseString | Set-Clipboard
    Write-Host "The converted string has been copied to the clipboard."
}

function uppercase {
    Write-Host "Please enter the string to convert to uppercase and copy to clipboard:"
    $InputString = Read-Host
    $lowerCaseString = $InputString.ToUpper()
    $lowerCaseString | Set-Clipboard
    Write-Host "The converted string has been copied to the clipboard."
}

function base64encode {
    Write-Host "Please enter the string to encode to Base64 and copy to clipboard:"
    $InputString = Read-MultiLineInput
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($InputString)
    $base64String = [Convert]::ToBase64String($bytes)

    if ($base64String.Length -le 100) {
        Write-Host "Base64 string: $base64String" -ForegroundColor Yellow
    } else {
        $first100Chars = $base64String.Substring(0, [Math]::Min(100, $base64String.Length))
        Write-Host "Truncated base64 string: $first100Chars..." -ForegroundColor Yellow
    }

    $base64String | Set-Clipboard
    Write-Host "The encoded string has been copied to the clipboard."
}

function base64decode {
    Write-Host "Please enter the Base64 encoded string to decode and copy to clipboard:"
    $InputString = Read-MultiLineInput
    $bytes = [Convert]::FromBase64String($InputString)
    $decodedString = [System.Text.Encoding]::UTF8.GetString($bytes)

    if ($decodedString.Length -le 100) {
        Write-Host "Decoded string: $decodedString" -ForegroundColor Yellow
    } else {
        $first100Chars = $decodedString.Substring(0, [Math]::Min(100, $decodedString.Length))
        Write-Host "Truncated decoded string: $first100Chars..." -ForegroundColor Yellow
    }

    $decodedString | Set-Clipboard
    Write-Host "The decoded string has been copied to the clipboard."
}
