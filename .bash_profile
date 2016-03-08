#screen
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# To make use of gpg-agent when not using X, uncomment #use-agent in ~/.gnupg/gpg.conf
eval "$(gpg-agent --daemon)"
export GPG_TTY=$(tty)

