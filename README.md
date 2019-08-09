My personal config files.

# Mac/Linux

```console
$ git clone git@github.com:tmtxt/dotfiles.git
$ ln -s .zshrc ~/.zshrc
$ ln -s .slate ~/.slate
$ ln -s .tmux.conf ~/.tmux.conf
$ ln -s Karabiner ~/Library/Application Support/Karabiner
$ ln -s .wgetrc ~/.wgetrc
$ ln -s conkeror-session-backup.sh ~/bin/conkeror-session-backup.sh
$ ln -s minecraft-server.sh ~/minecraft-server.sh
$ ln -s .jshint.json ~/.jshint.json
$ ln -s aria2/aria2-download-complete-mac.sh ~/bin/aria2-download-complete.sh
$ ln -s custom_chrome.sh ~/bin/custom_chrome.sh
$ ln -s .aspell.en.prepl ~/.aspell.en.prepl
$ ln -s .aspell.en.pws ~/.aspell.en.pws
$ ln -s Thunderbird/prefs.js ~/Library/Thunderbird/Profiles/profile.name/prefs.js
```

# Windows

Install `chocolatey` and `scoop` first.

Run these commands to install necessary packages (in Powershell)

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

scoop install `
    ag `
    concfg `
    curl `
    git-with-openssh `
    pshazz `
    sudo
```

Manually install these apps
* Cloudshot
* Visual studio
* SQL Server Developer
* SQL Management Studio
