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

alias open="x-www-browser"
alias xkcd="open https://c.xkcd.com/random/comic/"

alias tor-browser="( cd /opt/tor-browser_en-US && ./start-tor-browser.desktop )"
alias simple-server="python3 -m http.server"
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

