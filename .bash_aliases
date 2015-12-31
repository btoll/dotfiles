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
alias ssh_owl="ssh -p 1972 owlsnestfarm"

#alias cp="cp -p" #Cause cp to preserve the following attributes of each source file in the copy: modification time, access time, file flags, file mode, user ID, and group ID, as allowed by permissions.

alias barchiver="python3.4 /usr/local/src/git/tools/python3/barchiver.py"
alias brm="rm -rf"

# Open vim and immediately invoke CtrlP plugin.
alias vimP='vim -c ":CtrlP"'

# The Vim YouCompleteMe plugin needs the version of Vim to be at least 7.3.598, so
# unfortunately I needed to download MacVim and alias its Vim binary.
# I initially tried to symlink but had pathing issues, so screw it, do it here.
#alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
#alias vi="vim"

alias xkcd="open http://c.xkcd.com/random/comic/"
alias irc="irssi"
alias hangman="python3 /usr/local/src/git/games/python3/hangman/hangman.py"

# system aliases
alias web_start="sudo python3 -m http.server 80 --cgi"
alias web_stop='ps ax | grep "[p]ython3 -m http.server 80 --cgi" | sudo kill -9 $(cut -d" " -f2)'

alias pcrypt="python3 /usr/local/src/git/pcrypt/pcrypt.py"
alias utley="python3 /usr/local/src/git/utley/utley.py"
alias css_compress="python3 /usr/local/src/git/utley/css_compress.py"
alias js_compress="python3 /usr/local/src/git/utley/js_compress.py"

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

