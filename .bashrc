# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# If a fortune program is installed.
if [ -f ~/.bash_fortune ]; then
    . ~/.bash_fortune
fi

# Turn on git bash completion.
# http://git-scm.com/book/en/Git-Basics-Tips-and-Tricks
if [ -f ~/git-completion.bash ]; then
    . ~/git-completion.bash
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

export GREP_OPTIONS='--color=auto' GREP_COLOR='100;8'

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
    xterm-color) color_prompt=no;;
esac

# Set caps lock to ctrl key.
#setxkbmap -option ctrl:nocaps

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

#if [ "$color_prompt" = yes ]; then
#    #PS1="\e[0;36m\h:\w \e[m\e[0;32m[\A]\e[m> "
#    PS1="\u@\h:\w \A> "
#else
#    PS1="\h:\w [\A]> "
#fi
#unset color_prompt force_color_prompt
#
## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# If you work with git, you've probably had that nagging sensation of not knowing what branch you are on. Worry no longer!
export PS1="\\w:\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\$ "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

set -o vi
#shopt -s cdable_vars
#www=/usr/local/www
#shopt -s cdspell
bind -m vi-insert "\C-l":clear-screen #allows to clear screen when vi is set as my cli editor (not necessary if vi is not set)

# MacPorts Installer addition on 2011-07-11_at_12:55:29: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# For engineering bash scripts.
export WEBSERVER=/usr/local/www
export YUICOMPRESSOR=/usr/local/src/yuicompressor-2.4.8.jar
export PYTHONPATH=$PYTHONPATH:/usr/local/bin

# To make use of gpg-agent when not using X, uncomment #use-agent
# in ~/.gnupg/gpg.conf
eval "$(gpg-agent --daemon)"
export GPG_TTY=$(tty)

# Use vim as default editor instead of nano.
export EDITOR=vim

source ~/cdargs-bash.sh

export NODE_PATH=/usr/local/lib/jsctags:${NODE_PATH}

export GOPATH=/usr/local/src/git/go

export PATH="$GOPATH/bin:$HOME/.node_modules_global/bin:/usr/local/go/bin:$PATH"

export HISTIGNORE="stymie *:$HISTIGNORE"

