Install `chocolatey` and `scoop` first.

Run these commands to install necessary packages (in Powershell)

* Chocolatey packages
```console
choco install -y `
    7zip `
    cpu-z `
    gpu-z `
    emacs `
    googlechrome `
    firefox `
    discord `
    autohotkey `
    unikey `
    hackfont `
    hwinfo `
    itunes `
    jetbrains-rider `
    postman `
    pritunl-client `
    slack `
    sourcetree `
    steam `
    sublimetext3 `
    vscode
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
    nodejs-lts `
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
    pwsh
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
```

Manually install these apps
* Cloudshot
* Visual studio
* SQL Server Developer
* SQL Management Studio

Alias these commands

```console
Set-Alias -Name ll -Value Get-ChildItem
```
