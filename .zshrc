# HOME=${HOME%/}

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting
# for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git pass bower nvm npm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# custom display
# VIRTUAL_ENV_DISABLE_PROMPT=TRUE
# NTA XXX: Why doesn't it work with left prompt?
function tmtxt-virtualenv-info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`')'
}

function tmtxt-date {
    date '+%a %Y-%m-%d %T %Z'
}

function tmtxt-fill-bar {
    local term_width
    (( term_width = ${COLUMNS} - 1 ))

    local fill_bar=""
    local pwd_len=""

    # NTA TODO: Use $pwd_len & this
    # local pwdsize=${#${(%):-%~}}

    local user="%n"
    local host="%M"
    local current_dir="%~"
    local date="$(tmtxt-date)"

    # Left prompt's left part
    local left_left_prompt_size=${#${(%):-╭─ ${user}@${host} $(tmtxt-virtualenv-info) ${current_dir}}}
    # Left prompt's right part
    local left_right_prompt_size=${#${(%):-${date}}}
    local left_prompt_size
    (( left_prompt_size = ${left_left_prompt_size} + ${left_right_prompt_size} ))

    if [[ "$left_prompt_size" -gt $term_width ]]; then
        ((pwd_len=$term_width - $left_prompt_size))
    else
        fill_bar="${(l.(($term_width - $left_prompt_size - 6))..─.)}"
    fi

    echo "%{$fg[white]%} ${fill_bar} %{$reset_color%}"
}

# git variables
ZSH_THEME_GIT_PROMPT_PREFIX="%{$terminfo[bold]$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$terminfo[bold]$fg[red]%} ✘"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$terminfo[bold]$fg[yellow]%} °"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$terminfo[bold]$fg[green]%} ✔"

local user_host='%{$terminfo[bold]$fg[green]%}%n%{$fg[black]%}@%{$fg[red]%}%M%{$reset_color%}'
local virtual_env_info='$(tmtxt-virtualenv-info)'
local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local fill_bar='$(tmtxt-fill-bar)'
local date_time='%{$terminfo[bold]$fg[cyan]%}$(tmtxt-date)%{$reset_color%}'
local return_code="%(?..%{$terminfo[bold]$fg[red]%}%? ↵%{$reset_color%})"

PROMPT="
╭─ ${user_host} ${virtual_env_info} ${current_dir} ${fill_bar} ${date_time}
╰─%B%b "

RPROMPT='${return_code} $(git_prompt_info) %1'

# Determine platform
local unamestr=$(uname)
local platform=""
if [[ $unamestr == "Linux" ]]; then
    platform="Linux"
elif [[ $unamestr == "Darwin" ]]; then
    platform="Mac"
fi

# some useful alias
alias df='df -h'        # file system usage
alias du='du -h'        # du /path/to/file - File space usage
alias rs='rsync --progress -rv' # inside computer
alias rsl='rsync --progress -rv --inplace' # local
alias rsn='rsync --progress -rvz'      # network
alias jks='jekyll serve -w'          # jekyll server
alias sd='sudo shutdown -h'
alias mygcc="gcc -Wall -ansi -pedantic"
alias pg_stop='su postgres -c "pg_ctl stop -m fast"'
alias pg_start='su postgres -c "pg_ctl start"'
alias pg_restart='su postgres -c "pg_ctl restart"'
alias nda='nodemon app.js'
alias aria2='touch $HOME/Downloads/session.txt && aria2c --enable-rpc --rpc-listen-all --save-session=$HOME/Downloads/session.txt --input-file=$HOME/Downloads/session.txt -x16 -s16 -k1M --dir=$HOME/Downloads --daemon --on-download-complete=$HOME/bin/aria2-download-complete.sh'
alias nma="nodemon app.js"
alias rsyncmc="rsync -avz --progress --delete --exclude=mcbackup* -e ssh root@mineclgt.com:/home/minecraft/ ~/Downloads/mcbk/"
alias gd="gulp dev"
alias gw="gulp watch"
alias ap="ansible-playbook -f 10 -K"
alias vh="vagrant halt"
alias vu="vagrant up"
alias vs="vagrant ssh"
alias vp="vagrant provision"
alias vr="vagrant reload"
alias gcr="git clone --recursive"

# UTF8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# some config
if [[ $platform == "Linux" ]]; then
    # export path for dropbox
    PATH=$HOME/.dropbox-dist:$PATH

    # show details for ls command
    alias ls='ls -aCFho --color=auto'

elif [[ $platform == "Mac" ]]; then
    # macports-home path
    PATH=$HOME/bin/macports/bin:$HOME/bin/macports/sbin:$PATH
    PATH=$HOME/bin/macports/libexec/gnubin:$PATH
    PATH=$HOME/bin/macports/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
    PATH=$HOME/bin/macports/libexec/perl5.12:$PATH
    # PATH=$HOME/bin/boot2docker:$PATH
    PATH=$HOME/Sites/yii/framework:$PATH
    PERL5LIB=$HOME/bin/macports/lib/perl5/5.12.4:$HOME/bin/macports/lib/perl5/vendor_perl/5.12.4:$PERL5LIB

    # macports-system path
    PATH=$PATH:/opt/local/bin:/opt/local/sbin

    PATH=$HOME/bin/system:$PATH

    # postgresql
    export PATH=/Library/PostgreSQL/9.3/bin:$PATH
    export PGDATA=/Library/PostgreSQL/9.3/data
    export PGDATABASE=postgres
    export PGUSER=postgres
    export PGPORT=5432
    export PGLOCALEDIR=/Library/PostgreSQL/9.3/share/locale
    export MANPATH=$MANPATH:/Library/PostgreSQL/9.3/share/man
    export DOCKER_HOST=tcp://192.168.59.103:2375
    PATH=$HOME/bin/macports/lib/postgresql93/bin:$PATH

    # some useful alias
    alias port-home='$HOME/bin/macports/bin/port'
    alias port-system='sudo /opt/local/bin/port'
    alias portexpt='port -qv installed >' # "portexpt port.txt" export installed ports
    alias ckr="open -n $HOME/Applications/conkeror_mac_bundler/Conkeror.app" # conkeror
    alias cwd="pwd | pbcopy"  # copy working directory
    alias rmd="diskutil erasevolume HFS+ \"ramdisk\" `hdiutil attach -nomount ram://1165430`"
    alias nodns="sudo networksetup -setdnsservers Wi-Fi Empty"
    alias ggdns="sudo networksetup -setdnsservers Wi-Fi 8.8.8.8"
    alias rcs="$HOME/bin/reset-conkeror-session.sh"
    alias mcs="~/bin/minecraft-server.sh"
    alias wifion="networksetup -setairportpower en1 on"
    alias wifioff="networksetup -setairportpower en1 off"
    alias wifirs="networksetup -setairportpower en1 off && networksetup -setairportpower en1 on"
    alias conkeror="$HOME/Applications/conkeror_mac_bundler/Conkeror.app/Contents/MacOS/xulrunner"
    alias rsyncbk="sudo rsync -avz --progress --delete --exclude=.Spotlight* --exclude=.Trash* --exclude=.DocumentRevisions* --exclude=.fseventsd* --exclude=*.DS_Store*  /Volumes/tmtxt/ /Volumes/Pro/tmtxt/"
    # alias sudo="sudo -E -s"

    # ls alias when macports and no macports
    if [ -f $HOME/bin/macports/libexec/gnubin/ls ]; then
        alias ls='ls -aCFho --color=auto'
    else
        alias ls='ls -aCFho -G'
    fi

    # autojump with macports
    export FPATH="$FPATH:$HOME/bin/macports/share/zsh/site-functions/"
    if [ -f $HOME/bin/macports/etc/profile.d/autojump.zsh ]; then
        . $HOME/bin/macports/etc/profile.d/autojump.zsh
    fi

    autoload -U compinit
    compinit

    PASS_PATH=$(where pass)
    alias pass="$PASS_PATH -c"
    alias passs="$PASS_PATH show"
    alias passi="$PASS_PATH insert"
    alias passm="$PASS_PATH insert -m"
    alias passe="$PASS_PATH edit"
    alias passr="$PASS_PATH rm"
fi

. ~/.nvm/nvm.sh            # nvm

# PATH
PATH=$HOME/bin:$PATH    # my personal stuff
source ~/.rvm/scripts/rvm
PATH=$HOME/.rvm/scripts:$PATH     # rvm stuff
PATH=$HOME/.rvm/gems/ruby-2.0.0-p247/bin:$PATH
PATH=/usr/local/mysql/bin:$PATH # mysql path
PATH=$HOME/bin/aria2:$PATH
PATH=$HOME/bin/google_appengine:$PATH

# vagrant, disable live reload in vagrant
export VAGRANT_LIVE_RELOAD="0"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
