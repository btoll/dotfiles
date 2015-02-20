alias desk="cd ~/Desktop"
alias l="less"
alias ll="ls -lhF"
alias la="ls -lAhF"
alias lr="ls -lhFR"
alias lar="ls -lhFaR"
alias gzip="gzip -9"
alias bzip2="bzip2 -9"
alias ztar="tar czvf"
alias jtar="tar cjvf"
alias xztar="tar xzvf"
alias xjtar="tar xjvf"
alias cp="cp -i"
alias mv="mv -i"

alias tunnel="ssh -fND tunnel"

#alias cp="cp -p" #Cause cp to preserve the following attributes of each source file in the copy: modification time, access time, file flags, file mode, user ID, and group ID, as allowed by permissions.

alias brm="rm -rf"

# Open vim and immediately invoke CtrlP plugin.
alias vimP='vim -c ":CtrlP"'

# system and sencha aliases
alias sencha_bootstrap='pushd $SDK5/ext; sencha ant bootstrap; popd'

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias ..6="cd ../../../../../.."
alias ..7="cd ../../../../../../.."
alias ..8="cd ../../../../../../../.."
alias ..9="cd ../../../../../../../../.."
alias ..l="cd .. && ll"
alias :q="exit"

# git aliases
alias co4='cd $SDK4; git checkout extjs-4.2.x'
alias co5='cd $SDK5; git checkout sencha-5.0.x'

# debian
#alias sapt="apt-cache search"
#alias iapt="sudo apt-get install"
#alias papt="sudo apt-get purge"

alias mysqlstart="sudo /Library/StartupItems/MySQLCOM/MySQLCOM start"
alias mysqlstop="sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop"
alias mysqlstatus="ps aux | grep mysql | grep -v grep"

