$env:Path = "c:\Program Files\Git\usr\bin;" + $env:Path

Set-Alias -Name ll -Value Get-ChildItem -Option AllScope
Set-Alias -Name which -Value Get-Command -Option AllScope
Set-Alias -Name open -Value Invoke-Item -Option AllScope
Set-Alias -Name j -Value Invoke-ZLocation