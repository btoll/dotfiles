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

# Function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# turn on git bash completion
# http://git-scm.com/book/en/Git-Basics-Tips-and-Tricks
if [ -f ~/.git-completion.sh ]; then
    . ~/.git-completion.sh
fi

set -o vi
#shopt -s cdable_vars
#www=/usr/local/www
#shopt -s cdspell
bind -m vi-insert "\C-l":clear-screen #allows to clear screen when vi is set as my cli editor (not necessary if vi is not set)

# MacPorts Installer addition on 2011-07-11_at_12:55:29: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# For support and engineering bash scripts.
export EXT_SDK=../../..
export SDK4=/usr/local/www/SDK4/
export SDK5=/usr/local/www/SDK5/
export BUGS=/usr/local/www/extjs/bugs/
export EXT_BUILDS=../../builds
export TICKETS_DIR=/usr/local/www/extjs/tickets/
export BOOTSTRAP_LOCATION=/usr/local/www/SDK5/ext/

#export CDPATH=.:/usr/local/www/extjs:/usr/local/www/extjs/builds:/usr/local/www

source /usr/local/Cellar/cdargs/1.35/contrib/cdargs-bash.sh

export SENCHA_CMD_3_0_0="/Users/btoll/bin/Sencha/Cmd/5.1.1.38"

export NODE_PATH=/usr/local/lib/jsctags:${NODE_PATH}

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.0.42:/usr/local/mysql/bin:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.0.73:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.0.89:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.0.115:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.0.145:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.0.157:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.1.178:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.0.116:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.1.204:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.3.320:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.0.4.342:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.1.0.13:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.1.0.21:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.1.0.25:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.1.0.26:$PATH

export PATH=/Users/btoll/bin/Sencha/Cmd/5.1.1.38:$PATH

# I compiled a newer version of Vim (7.4) and put it in the below path instead of overwriting the native Vim.
export PATH=/opt/local/bin:$PATH
