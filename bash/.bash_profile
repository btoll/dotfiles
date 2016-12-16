if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# All user env vars.
if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

# To make use of gpg-agent when not using X, uncomment `use-agent`
# in ~/.gnupg/gpg.conf.
eval "$(gpg-agent --daemon)"
export GPG_TTY=$(tty)

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

