# shellcheck disable=2139

# Fixes "-bash: cd: gen: No such file or directory" error.
# If the value of an alias ends in a blank, then bash tries
# to do alias substitution on the next word in the command
# line. - Learning the Bash Shell, 2nd edition, page 62.
#alias cd="cd "

alias g="git"
alias gi="git"
alias v="vim"
alias vi="vim"

alias l="less"
alias ll="ls -lhF"
alias la="ls -lAhF"
alias lss="ls -1"
alias lsl="lss"
alias lsa="lss -a"
alias gzip="gzip -9"
alias bzip2="bzip2 -9"
alias cp="cp -i"
alias ln="ln -i"
alias mv="mv -i"
alias c="cd"
alias ping="ping -c 4"

# Always enable colored `grep` output.
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Job Control
alias j="jobs -l"
alias f="fg"
alias b="bg"

alias gdb="gdb -q"
alias brm="rm -rf"

alias open="xdg-open"
alias xkcd="open https://c.xkcd.com/random/comic/"
alias little-bobby-tables="open https://xkcd.com/327/"

# https://github.com/jessfraz/dockerfiles/issues/329
# xhost +local:root
alias tor-browser="docker run --device /dev/snd -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/shm:/dev/shm -v /etc/machine-id:/etc/machine-id:ro -e DISPLAY=unix$DISPLAY -e TOR_VERSION=10.5.6 --name tor-browser jessfraz/tor-browser:latest &> /dev/null &"
# To specify port, just add it at the end of the python command.
alias serve="python -m http.server"
alias chrome-browser-disable-security="/usr/bin/google-chrome-stable --disable-web-security --user-data-dir=/tmp/chrome-disable-web-security"

# Git
alias bootstrap="git bootstrap"
alias dirty="git dirty"

alias hibernate="systemctl hibernate"
alias suspend="systemctl suspend"

alias ..="cd .."
alias ..1="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ..6="cd ../../../../../.."
alias ..7="cd ../../../../../../.."
alias ..8="cd ../../../../../../../.."
alias ..9="cd ../../../../../../../../.."
alias ..l="ll .."

alias :q="exit"
alias :x="exit"

alias suod=sudo

