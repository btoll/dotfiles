if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

########
# TODO: Make sure that all shells (noninteractive in particular) inherit the env vars!
########
# All user env vars.
if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

