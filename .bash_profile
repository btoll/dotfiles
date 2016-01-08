#screen
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# All user env vars.
if [ -f ~/.bash_env ]; then
    . ~/.bash_env
fi

# If a fortune program is installed.
if [ -f ~/.bash_fortune ]; then
    . ~/.bash_fortune
fi

# Function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f ~/cdargs-bash.sh ]; then
    . ~/cdargs-bash.sh
fi

# Turn on git bash completion.
# http://git-scm.com/book/en/Git-Basics-Tips-and-Tricks
if [ -f ~/git-completion.bash ]; then
    . ~/git-completion.bash
fi

