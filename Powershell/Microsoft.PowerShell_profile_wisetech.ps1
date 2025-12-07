$hardLinks = @(& fsutil hardlink list $PSCommandPath 2>$null | Where-Object { $_.Trim() -ne '' })
$profilePath = if ($hardLinks.Count -gt 1) { $hardLinks[1] } else { $hardLinks[0] }
$profileFolder = Split-Path -Parent $profilePath
Write-Host "Profile folder: $profileFolder";

# have to hard code here because this file is usually symlinked into Documents folder, cannot detect its own location
$LocalModules = "C:\projects\dotfiles\Powershell\Modules"
$env:PSModulePath += ";$LocalModules"

Write-Output "Script root: $PSScriptRoot"
Write-Output "Command path: $PSCommandPath"

Set-Alias -Name ll -Value Get-ChildItem -Option AllScope
Set-Alias -Name which -Value Get-Command -Option AllScope
Set-Alias -Name open -Value Invoke-Item -Option AllScope

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/minimal.omp.json" | Invoke-Expression

Import-Module ZLocation
Set-Alias -Name j -Value Invoke-ZLocation

$env:Path = "c:\Program Files\Git\usr\bin;" + $env:Path
$env:Path += ";C:\Users\tony.tran\AppData\Roaming\npm"
$env:Path = "C:\Users\Tony.Tran\.local\bin;$env:Path"

Import-Module MyUtils

Function uuidv4Lower {
    (New-Guid).Guid | Set-Clipboard
    Write-Output "New uuidv4 (lower-case) copied to clipboard"
}

function RandomString {
    param (
        [int]$length = 10
    )

    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    $random = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count $length | ForEach-Object { [char]$_ })
    $random | Set-Clipboard
    return $random
}

function Lowercase {
    Write-Host "Please enter the string to convert to lowercase and copy to clipboard:"
    $InputString = Read-Host
    $lowerCaseString = $InputString.ToLower()
    $lowerCaseString | Set-Clipboard
    Write-Host "The converted string has been copied to the clipboard."
}

function Uppercase {
    Write-Host "Please enter the string to convert to uppercase and copy to clipboard:"
    $InputString = Read-Host
    $lowerCaseString = $InputString.ToUpper()
    $lowerCaseString | Set-Clipboard
    Write-Host "The converted string has been copied to the clipboard."
}

function Base64Encode {
    Write-Host "Please enter the string to encode to Base64 and copy to clipboard:"
    $InputString = Read-MultiLineInput
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($InputString)
    $base64String = [Convert]::ToBase64String($bytes)

    if ($base64String.Length -le 100) {
        Write-Host "Base64 string: $base64String" -ForegroundColor Yellow
    }
    else {
        $first100Chars = $base64String.Substring(0, [Math]::Min(100, $base64String.Length))
        Write-Host "Truncated base64 string: $first100Chars..." -ForegroundColor Yellow
    }

    $base64String | Set-Clipboard
    Write-Host "The encoded string has been copied to the clipboard."
}

function Base64Decode {
    Write-Host "Please enter the Base64 encoded string to decode and copy to clipboard:"
    $InputString = Read-MultiLineInput
    $bytes = [Convert]::FromBase64String($InputString)
    $decodedString = [System.Text.Encoding]::UTF8.GetString($bytes)

    if ($decodedString.Length -le 100) {
        Write-Host "Decoded string: $decodedString" -ForegroundColor Yellow
    }
    else {
        $first100Chars = $decodedString.Substring(0, [Math]::Min(100, $decodedString.Length))
        Write-Host "Truncated decoded string: $first100Chars..." -ForegroundColor Yellow
    }

    $decodedString | Set-Clipboard
    Write-Host "The decoded string has been copied to the clipboard."
}

function LoremIpsum {
    $loremIpsum = @"
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"@

    # Copy the text to the clipboard
    Set-Clipboard -Value $loremIpsum
    Write-Host "Lorem Ipsum copied to clipboard"
}

function PcName {
    # Get the current PC name
    $pcName = $env:COMPUTERNAME

    # Copy the PC name to the clipboard
    Set-Clipboard -Value $pcName

    Write-Host "PC Name $pcName copied to clipboard"
}

function PcFullName {
    # Get the full device name
    $pcName = (Get-WmiObject -Class Win32_ComputerSystem).Name
    $domainName = (Get-WmiObject -Class Win32_ComputerSystem).Domain
    $fullDeviceName = "$pcName.$domainName"

    # Copy the full device name to the clipboard
    Set-Clipboard -Value $fullDeviceName

    Write-Host "Full Device Name $fullDeviceName copied to clipboard"
}

function UnescapeString {
    $input = Read-Host "Enter the string to unescape"

    # Remove surrounding double quotes if present
    if ($input.StartsWith('"') -and $input.EndsWith('"')) {
        $input = $input.Substring(1, $input.Length - 2)
    }

    $unescapedString = [System.Text.RegularExpressions.Regex]::Unescape($input)
    Write-Output ""
    Write-Output $unescapedString

    # Copy the unescaped string to the clipboard
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Clipboard]::SetText($unescapedString)

    Write-Host ""
    Write-Host "Unescape string copied to clipboard"
}

function CopyGitBranchName {
    # Get the current git branch name
    $branchName = git rev-parse --abbrev-ref HEAD

    # Copy the branch name to the clipboard
    $branchName | Set-Clipboard

    Write-Output "Current branch name '$branchName' copied to clipboard."
}

function LoginNetwork {
    $Password = Get-Content -Path "c:\Users\tony.tran\Downloads\mypassword.txt"
    net use \\datfiles.wtg.zone /user:tony.tran@wisetechglobal.com $Password
    net use \\au2sp-srfd-402.sand.wtg.zone /user:tony.tran@wisetechglobal.com $Password
    # put all the folders here...
}

function CopyDbUpgrader {
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\Enterprise.DbUpgrader.Resource.dll" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\Enterprise.DbUpgrader.Resource.pdb" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.Odyssey.Schema.dll" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net472\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\CargoWise.Odyssey.Schema.pdb" -Force

    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\Enterprise.DbUpgrader.Resource.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\Enterprise.DbUpgrader.Resource.dll" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\Enterprise.DbUpgrader.Resource.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\Enterprise.DbUpgrader.Resource.pdb" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.dll" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.DbUpgrader.Scripts.Definitions.pdb" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.Odyssey.Schema.dll" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.Odyssey.Schema.dll" -Force
    Copy-Item -Path "C:\git\GitHub\WiseTechGlobal\CargoWise.Shared\CargoWise.DbUpgrader\Bin\net8.0\CargoWise.Odyssey.Schema.pdb" -Destination "c:\git\GitHub\WiseTechGlobal\CargoWise\Bin\net8.0\CargoWise.Odyssey.Schema.pdb" -Force
}