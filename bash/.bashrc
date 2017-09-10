if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/.cdargs-bash.sh ]; then
    . ~/.cdargs-bash.sh
fi

# Turn on git bash completion.
# http://git-scm.com/book/en/Git-Basics-Tips-and-Tricks
if [ -f ~/git-completion.bash ]; then
    . ~/git-completion.bash
fi

# xterm color settings.
# Note, this should be in .xinitrc to be read when the startx wrapper in invoked by xinit, but it no worky.
if [ -f ~/.Xresources ]; then
    xrdb -merge ~/.Xresources
fi

# If a fortune program is installed.
if which fortune > /dev/null; then
    if which cowsay > /dev/null; then
        fortune | cowsay -W 60
    else
        fortune
    fi
fi

# Disable <CTRL-d> which is used to logout of a login shell
# (local or remote login session over ssh).
set -o ignoreeof

# Prevent file overwrite on stdout redirection.
# Use '>|' to force redirection to an existing file.
set -o noclobber

set -o vi
#shopt -s cdspell

# By setting the bell length to 0, all console beeps are
# disabled while running from the shell.
if [ -z $XTERM_SHELL ]; then
    setterm -blength 0
fi

# Append to the history file, don't overwrite it.
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Turn on recursive globbing.
if [ "${BASH_VERSINFO}" -ge 4 ]; then
    shopt -s globstar
fi

# Prepend cd to directory names automatically.
shopt -s autocd 2> /dev/null

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below).
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set caps lock to ctrl key.
#setxkbmap -option ctrl:nocaps

# Uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt.
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

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# Allows to clear screen when vi is set as my cli editor (not necessary if vi is not set).
bind -m vi-insert "\C-l":clear-screen

# Enable history expansion with [[space]].
# E.g., typing !![[space]] will replace the !! with your last command!
# No more appending `:p` to do a dry-run of the expansion!!
bind Space:magic-space

# Default to opening or creating a new tmux session when opening a terminal.
#if [[ "$TERM" != "screen-256color" ]]; then
#    tmux attach-session -t "$USER" || tmux new-session -s "$USER"
#fi

