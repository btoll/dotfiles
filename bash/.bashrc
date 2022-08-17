# shellcheck disable=1090,2034

if [ -f "$HOME/.bash_aliases" ]
then
    . "$HOME/.bash_aliases"
fi

if [ -f "$HOME/.bash_functions" ]
then
    . "$HOME/.bash_functions"
fi

if [ -f "$HOME/.bash_options" ]
then
    . "$HOME/.bash_options"
fi

if [ -f "$HOME/.bash_vendor" ]
then
    . "$HOME/.bash_vendor"
fi

if [ -f "$HOME/.Xresources" ]
then
    xrdb -merge "$HOME/.Xresources"
fi

#if declare -f dim_screen > /dev/null
#then
#    dim_screen .7
#fi

# Map Caps Lock to Ctrl.
#if [ -f $HOME/.Xmodmap ]; then
#    xmodmap $HOME/.Xmodmap
#fi

# If a fortune program is installed.
if command -v fortune > /dev/null
then
    if command -v cowsay > /dev/null
    then
        fortune -e | cowsay -W 60 -f stegosaurus
    else
        fortune -e
    fi
fi

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below).
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt.
force_color_prompt=yes

if [ -n "$force_color_prompt" ]
then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null
    then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]
then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# Allows to clear screen when vi is set as my command-line editor (not necessary if vi is not set).
bind -m vi-insert "\C-l":clear-screen

# Enable history expansion with [[space]].
# E.g., typing !![[space]] will replace the !! with your last command!
# No more appending `:p` to do a dry-run of the expansion!!
bind Space:magic-space

# Allow access control for localhost with Xorg.
# Especially needed for browsers (like tor) running in containers.
if [ -n "$DISPLAY" ]
then
    xhost +local:sulla
fi

# Default to opening or creating a new tmux session when opening a terminal.
#if [[ "$TERM" != "screen-256color" ]]; then
#    tmux attach-session -t "$USER" || tmux new-session -s "$USER"
#fi

