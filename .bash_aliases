alias desk="cd ~/Desktop"
alias l="less"
alias ll="ls -lhF"
alias la="ls -lAhF"
alias lr="ls -lhFR"
alias lar="ls -lhFaR"
alias gzip="gzip -9"
alias bzip2="bzip2 -9"
alias cp="cp -i"
alias mv="mv -i"

alias tunnel="ssh -fND tunnel"

#alias cp="cp -p" #Cause cp to preserve the following attributes of each source file in the copy: modification time, access time, file flags, file mode, user ID, and group ID, as allowed by permissions.

alias barchiver="python3.4 /usr/local/www/tools/python3/barchiver.py"
alias brm="rm -rf"

# Open vim and immediately invoke CtrlP plugin.
alias vimP='vim -c ":CtrlP"'
alias vimBP='vim -c ":normal iboilerplate"'

# The Vim YouCompleteMe plugin needs the version of Vim to be at least 7.3.598, so
# unfortunately I needed to download MacVim and alias its Vim binary.
# I initially tried to symlink but had pathing issues, so screw it, do it here.
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias vi="vim"

alias xkcd="open http://c.xkcd.com/random/comic/"
alias irc="irssi"
alias hangman="python3 /usr/local/www/games/python3/hangman/hangman.py"

# system and sencha aliases
alias start_web="pushd /usr/local/www; sudo python3 -m http.server 80 --cgi; popd"
alias stop_web='ps ax | grep "[p]ython3 -m http.server 80 --cgi" | sudo kill $(cut -d" " -f1)'
alias pcrypt="python3 /usr/local/www/pcrypt/pcrypt.py"
alias utley="python3 /usr/local/www/utley/utley.py"
alias css_compress="python3 /usr/local/www/utley/css_compress.py"
alias js_compress="python3 /usr/local/www/utley/js_compress.py"

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
alias co6='cd $SDK6; git checkout sencha-6.0.x'

alias mysqlstart="sudo /Library/StartupItems/MySQLCOM/MySQLCOM start"
alias mysqlstop="sudo /Library/StartupItems/MySQLCOM/MySQLCOM stop"
alias mysqlstatus="ps aux | grep mysql | grep -v grep"

