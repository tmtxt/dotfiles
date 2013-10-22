# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME=""

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias mygcc="gcc -Wall -ansi -pedantic"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

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
alias df='df -h'				# file system usage
alias du='du -h'				# du /path/to/file - File space usage
alias rs='rsync --progress -rv'	# inside computer
alias rsl='rsync --progress -rv --inplace' # local
alias rsn='rsync --progress -rvz'		   # network
alias jks='jekyll serve -w'				   # jekyll server
alias sd='sudo shutdown -h'

# some config
if [[ $platform == "Linux" ]]; then
	# show details for ls command
	alias ls='ls -aCFho --color=auto'

	# export path for dropbox
	PATH=~/.dropbox-dist:$PATH
elif [[ $platform == "Mac" ]]; then
	# PATH for GNU stuffs
	PATH=/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:/opt/bin:$PATH
	
	# mysql path on mac os
	PATH=/usr/local/mysql/bin:$PATH
	
	# boxen
	# [ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
	# alias boxen='boxen --debug'
	PATH=/Volumes/tmtxt/.rvm/gems/ruby-1.9.3-p448/bin:$PATH

	# show details for ls command
	alias ls='ls -aCFho -G'

	alias portexpt='port -qv installed >' # export installed ports in mac port
								# to a file, usage: portexpt filename.txt
	
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin	  # my personal stuff

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
