# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

unset PROMPT_COMMAND

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm*|linux) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

MAX_PWD_LENGTH=25
export PROMPT_COMMAND='PWD_SHORT=$(perl -pl0e "s|^$HOME|~|; \$_=qq(\$_/); while(length>$MAX_PWD_LENGTH && s:[_-][^/_-]+/:/:){}; chop; while(length > $MAX_PWD_LENGTH && s:(\.*[^/.])[^/]+/:\$1/:){}" <<< $PWD)'

# for branch name in the promt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

if [ "$color_prompt" = yes ]; then
    #Using UNICODE and patched font (<some name> for Powerline)
    COLOR256_VENV_BG_COLOR="1"
    COLOR256_VENV_FG_COLOR="15"
    COLOR256_USER_BG_COLOR="11"
    COLOR256_USER_FG_COLOR="0"
    COLOR256_BRANCH_BG_COLOR="4"
    COLOR256_BRANCH_FG_COLOR="15"
    COLOR256_DIR_BG_COLOR="14"
    COLOR256_DIR_FG_COLOR="0"
    COLOR256_BG_PREFIX="48;5;"
    COLOR256_FG_PREFIX="38;5;"
    PREFIX="\[\033["
    SUFFIX="m\]"
    RESET="${PREFIX}0${SUFFIX}"
    VENV_START="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_VENV_FG_COLOR};${COLOR256_BG_PREFIX}${COLOR256_VENV_BG_COLOR}${SUFFIX}"
    VENV_TO_USER="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_VENV_BG_COLOR};${COLOR256_BG_PREFIX}${COLOR256_USER_BG_COLOR}${SUFFIX}"
    USER_START="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_USER_FG_COLOR};${COLOR256_BG_PREFIX}${COLOR256_USER_BG_COLOR}${SUFFIX}"
    USER_TO_BRANCH="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_USER_BG_COLOR};${COLOR256_BG_PREFIX}${COLOR256_BRANCH_BG_COLOR}${SUFFIX}"
    USER_TO_DIR="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_USER_BG_COLOR};${COLOR256_BG_PREFIX}${COLOR256_DIR_BG_COLOR}${SUFFIX}"
    BRANCH_START="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_BRANCH_FG_COLOR}${SUFFIX}"
    BRANCH_TO_DIR="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_BRANCH_BG_COLOR};${COLOR256_BG_PREFIX}${COLOR256_DIR_BG_COLOR}${SUFFIX}"
    DIR_START="${PREFIX}${COLOR256_FG_PREFIX}${COLOR256_DIR_FG_COLOR}${SUFFIX}"
    DIR_END="${PREFIX}0;${COLOR256_FG_PREFIX}${COLOR256_DIR_BG_COLOR}${SUFFIX}"

    SEP_CHAR=""
    BRANCH_CHAR=""
    DIRTY_CHAR="✎"
    CONFLICT_LEFT_CHAR="→"
    CONFLICT_RIGHT_CHAR="←"
    PS1="${RESET}\${VIRTUAL_ENV_NAME:+${VENV_START} \${VIRTUAL_ENV_NAME} ${VENV_TO_USER}${SEP_CHAR}}${USER_START} \h \${not_git_branch+${USER_TO_DIR}${SEP_CHAR}}\${git_branch:+${USER_TO_BRANCH}${SEP_CHAR}${BRANCH_START} ${BRANCH_CHAR} \$git_branch\${git_dirty:+ \${in_git_merge+${CONFLICT_LEFT_CHAR}}${DIRTY_CHAR}\${in_git_merge+${CONFLICT_RIGHT_CHAR}}} ${BRANCH_TO_DIR}}${DIR_START} \$PWD_SHORT ${DIR_END}${RESET} "
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[00;33m\]\u@\h \[\033[00;90m\][\[\033[00;36m\]\w\[\033[00;90m\]] \[\033[00;33m\]>\[\033[00m\] '
    # old original
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\]\u@\h\[\033[01;34m\]:\w\[\033[00;32m\] >\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    if [ -x /usr/bin/dircolors ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
        #alias dir='ls --color=auto --format=vertical'
        #alias vdir='ls --color=auto --format=long'

        alias grep='grep --color=auto'
        #alias fgrep='fgrep --color=auto'
        #alias egrep='egrep --color=auto'
    fi
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Set notify if you want to be asynchronously notified about background
# job completion.
set -o notify

export SVN_EDITOR=/usr/bin/vim

# Up/Down completes from hestory from beggining of the line
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# TAB completes to first possibility
bind 'TAB:menu-complete'


source ~/.aliases

# define less options
#       -S          Chop long lines
export LESS="-S -M"

export PATH=$HOME/bin:$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib

# UDM specific
export UDM_BASE_RECORD_ID=5550000
export UDM_REG_BASE_RECORD_ID=123000000
