# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# If a fortune program is installed.
if which fortune > /dev/null; then
    if which cowsay > /dev/null; then
        fortune | cowsay -W 60
    else
        fortune
    fi
fi

