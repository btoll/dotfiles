# shellcheck disable=1090

if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

########
# TODO: Make sure that all shells (noninteractive in particular) inherit the env vars!
########
# All user env vars.
if [ -f "$HOME/.bash_env" ]; then
    . "$HOME/.bash_env"
fi

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

