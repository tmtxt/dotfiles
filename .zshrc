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
plugins=(git pass bower nvm npm mix)

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

# source if exist
function source_s {
    [[ -s "$1" ]] && source "$1"
}

# add path if exist
# default to append to $PATH, pass second argument true to prepend
function path_s {
    if [ -d "$1" ]; then
        if [ $2 ]; then
            PATH="$1:$PATH"
        else
            PATH="$PATH:$1"
        fi
    fi
}

# zip the input with the current name is the current date time
function zz {
    zip -r $(date +%Y-%m-%d-%H-%M-%S).zip $1
}

# combine the input files to one mkv video using ffmpeg
function cv {
    declare -a args
    for arg in $@; do
        args+=('-i')
        args+=($arg)
    done
    args+=("-acodec")
    args+=("copy")
    args+=("-vcodec")
    args+=("copy")
    args+=("output.mkv")

    ffmpeg "${args[@]}"
}

# calculate md5 string
function mmd5 {
    if [[ -z "$1" ]]; then
        echo "No value supplied"
    else
        val=$(echo -n "$1" | md5sum | awk '{print $1}')
        echo $val
        if [[ $platform == "Mac" ]]; then
            echo $val | pbcopy
            echo "MD5 string coppied to clipboard"
        fi
    fi
}

# generate uuid
function uuidv4 {
    local uuid=$(uuidgen | awk '{print tolower($0)}')
    echo -n "$uuid" | pbcopy
    echo "$uuid copied to clipboard"
}

# some useful alias
alias df='df -h'        # file system usage
alias du='du -h'        # du /path/to/file - File space usage
alias rs='rsync -avz --progress' # inside computer
alias jks='jekyll serve -w -D'          # jekyll server
alias sd='sudo shutdown -h'
alias mygcc="gcc -Wall -ansi -pedantic"
alias pg_stop='su postgres -c "pg_ctl stop -m fast"'
alias pg_start='su postgres -c "pg_ctl start"'
alias pg_restart='su postgres -c "pg_ctl restart"'
alias aria2='touch $HOME/Downloads/session.txt && aria2c --enable-rpc --rpc-listen-all --save-session=$HOME/Downloads/session.txt --input-file=$HOME/Downloads/session.txt -x16 -s16 -k1M --dir=$HOME/Downloads --daemon --on-download-complete=$HOME/bin/aria2-download-complete.sh'
alias gd="gulp dev"
alias gw="gulp watch"
alias vh="vagrant halt"
alias vu="vagrant up"
alias vs="vagrant ssh"
alias vp="vagrant provision"
alias vr="vagrant reload"
alias gcr="git clone --recursive"
alias gp="git pull"
alias tl="tmux ls"
alias tn="tmux new -s"
alias ta="tmux a -t"
alias ta0="tmux a -t 0"
alias tk="tmux kill-session -t"
alias tk0="tmux kill-session -t 0"
alias dck="docker-compose kill"
alias dcd="docker-compose down"
alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcp="docker-compose ps"
alias dcr="docker-compose rm"
alias dcl="docker-compose logs -f --tail=100"
alias dcb="docker-compose build"
alias kb="kubectl"
alias kbs="kubectl --context=staging"
alias kbsl="kubectl --context=staging logs --tail=100 -f"
alias kbp="kubectl --context=production"
alias kbpl="kubectl --context=production logs --tail=100 -f"
alias nrts="npm run truong-stg"
alias nrtp="npm run truong-prod"
alias sstg=". ~/.bashrc-workflow-stg"
alias sprd=". ~/.bashrc-workflow-prod"
alias pst="pm2 start"
alias plg="pm2 logs"
alias pls="pm2 ls"
alias docker-remove-all-images="docker rm \$(docker ps -a -q) && docker rmi \$(docker images -q)"

# password store
PASS_PATH=$(where pass)
alias pass="$PASS_PATH -c"
alias passs="$PASS_PATH show"
alias passi="$PASS_PATH insert"
alias passm="$PASS_PATH insert -m"
alias passe="$PASS_PATH edit"
alias passr="$PASS_PATH rm"
alias pgps="$PASS_PATH git push"
alias pgpl="$PASS_PATH git pull"

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
    # macport path
    if [ -d $HOME/bin/macports ]; then
        MPP=$HOME/bin/macports
    else
        MPP=/opt/local
    fi

    # macports path
    path_s $MPP/bin true
    path_s $MPP/sbin true
    path_s $MPP/libexec/gnubin true
    path_s $MPP/Library/Frameworks/Python.framework/Versions/Current/bin true
    path_s $HOME/bin/system
    PERL5LIB=$MPP/lib/perl5/5.12.4:$MPP/lib/perl5/vendor_perl/5.12.4:$PERL5LIB

    # some useful alias
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
    alias pi="sudo port install"

    # ls alias when macports and no macports
    if [ -f $MPP/libexec/gnubin/ls ]; then
        alias ls='ls -aCFho --color=auto'
    else
        alias ls='ls -aCFho -G'
    fi

    # autojump with macports
    export FPATH="$FPATH:$MPP/share/zsh/site-functions/"
    if [ -f $MPP/etc/profile.d/autojump.sh ]; then
        . $MPP/etc/profile.d/autojump.sh
    fi
    autoload -U compinit
    compinit
fi

# PATH
path_s $HOME/bin true
path_s $HOME/bin/aria2 true
path_s $HOME/.nvm/nvm.sh
path_s $HOME/.composer/vendor/bin
path_s /Applications/Emacs.app/Contents/MacOS/bin true
path_s $HOME/Applications/Emacs.app/Contents/MacOS/bin true

# vagrant, disable live reload in vagrant
export VAGRANT_LIVE_RELOAD="0"
export EDITOR="emacsclient"

source_s "$HOME/.gvm/scripts/gvm"
source_s "$HOME/.rvm/scripts/rvm"
source_s "$HOME/bin/google-cloud-sdk/path.zsh.inc"
source_s "$HOME/bin/google-cloud-sdk/completion.zsh.inc"

# kubectl get name of entity
# $1 type: po, no, rc, svc
# $2 grep, empty for nothing
function kubectl_get_name {
    result=$(kubectl get $1 | grep "$2")
    arr=($(echo $result | awk '{print $1}'))
    echo $result | cat -n
    echo -n "Select the number: "
    read num
    local res=${arr[$num]}
    eval $3=\$res
}

function kbc {
    kubectl_get_name $1 $2 "KBC_RESULT"
    echo -n $KBC_RESULT | pbcopy
    echo "Copied $KBC_RESULT to clipboard"
}

function kbsc {
    if [[ -z "$1" ]]; then
        echo -n "Enter grep text: "
        read text
        kubectl_get_name rc $text "KBS_RESULT"
        local rc=$KBS_RESULT
        echo -n "Enter replicas: "
        read rep
        local replicas=$rep
    else
        local rc=$1
        local replicas=$2
    fi

    kubectl scale rc $rc --replicas=$replicas
    echo "Scaled $rc to $replicas instances"
}

function sshstg {
    ssh "core@10.9.8.$1"
}

function sshprd {
    ssh "core@192.168.167.$1"
}

function rsi {
    rsync -avz --progress core@192.168.167.127:/data/integration/$1 ./
}

export MOZ_PURGE_CACHES=true
# launchctl setenv MOZ_PURGE_CACHES true

export NODE_PATH=~/.nvm/versions/node/v4.1.2/lib/node_modules
