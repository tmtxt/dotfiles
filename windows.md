Install `chocolatey` and `scoop` first.

# Install using Package Manager (Powershell)

* Chocolatey packages
```console
choco install -y `
    7zip `
    googlechrome `
    autohotkey `
    hackfont `
    jetbrains-rider `
    postman `
    vscode `
    firefox
```

* Scoop packages
```console
scoop bucket add extras

scoop install `
    ag `
    concfg `
    curl `
    git-with-openssh `
    pshazz `
    sudo `
    ruby `
    nvm `
    empty-recycle-bin `
    wget `
    which `
    touch `
    time `
    telnet `
    simple-http-server `
    say `
    redis `
    aws `
    grep `
    gcloud `
    kubectl `
    emacs `
    winscp `
    pwsh `
    ffmpeg `
    youtube-dl
```

* Npm modules
```
npm install -g `
    gulp `
    livedown
```

* Powershell modules
```
Install-Module -Name AWSPowerShell
Install-Module ZLocation -Scope CurrentUser
```

# Install Manually

Manually install these apps
* Cloudshot
* Visual studio
* SQL Server Developer
* SQL Management Studio

# Environment Variables

Set these Environment variables
```
GIT_SSH=C:\Windows\System32\OpenSSH\ssh.exe
```

# Symlinks

Run in Administrator `cmd` (update the path accordingly)
**Note**: Only symlink after finishing installing the above packages
```
> mklink /H "C:\Users\me\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" "C:\Users\me\Projects\dotfiles\Powershell\Microsoft.PowerShell_profile.ps1"
```
