# Fixes "-bash: cd: gen: No such file or directory" error.
# If the value of an alias ends in a blank, then bash tries
# to do alias substitution on the next word in the command
# line. - Learning the Bash Shell, 2nd edition, page 62.
alias cd="cd "

alias g="git"
alias gpg="gpg2"
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
alias mv="mv -i"
alias c="cd"

# Always enable colored `grep` output.
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Job Control
alias j="jobs"
alias f="fg"
alias b="bg"

alias gdb="gdb -q"

#alias cp="cp -p" #Cause cp to preserve the following attributes of each source file in the copy: modification time, access time, file flags, file mode, user ID, and group ID, as allowed by permissions.

alias brm="rm -rf"

alias xkcd="open http://c.xkcd.com/random/comic/"

alias irc="irssi"
alias tor-browser="( cd /opt/tor-browser-linux64-8.0.4_en-US/tor-browser_en-US && ./start-tor-browser.desktop )"

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

