bfind() {
    vim -p $(find "$1" -type f -name "$2")
}

bgrep() {
    vim -p "+/$1" $(grep -riIl "$1" "$2" | uniq)
}

cdl() {
    if [ -z "$1" ]; then
        echo "Usage: cdl <DIR>"
    else
        cd "$1" && ls -l
    fi
}

# Deprecating this in favor of https://github.com/btoll/dump_describes node module.
#dump_describes() {
#    sed -n -E 's/^[[:space:]]{1,7}describe\('\(.*\)'/\1/p' "$1" | cut -d, -f1
#}

# Setup script boilerplate.
bp() {
    if [ "$#" -lt 2 ]; then
        echo "[ERROR] Not enough arguments!"
        echo "Usage: bp <type> <filename>"
    elif [ "$1" == "go" ]; then
        vim -c ":normal igoBP" "$2"
    elif [ "$1" == "html" ]; then
        vim -c ":normal ihtmlBP" "$2"
    fi
}

git_clone() {
    if [ -z "$1" ]; then
        echo "Usage: git_clone <REPO>"
    else
        git clone "$1"
        git_hooks_install
    fi
}

git_hooks_install() {
    if [ -z "$GITHOOKS" ]; then
        read -p "Location of git hooks (skip this step by exporting a \$GITHOOKS env var): " LOCATION

        GITHOOKS="$LOCATION"
    fi

    cp -r "$GITHOOKS"/* .git/hooks/
}

git_init() {
    git init
    git_hooks_install
}

intersect() {
    # http://askubuntu.com/a/472280
    if [ "$#" -eq 0 ]; then
        echo "Usage: intersect FILE1 FILE2 [ REGEXP ]"
    else
        REGEXP=${3:-'\w* ?: ?((function)|(Ext.emptyFn)|(Ext.identityFn))'}
        sort <(egrep -o "$REGEXP" "$1" | cut -d: -f1 | sort | uniq) <(egrep -o "$REGEXP" "$2" | cut -d: -f1 | sort | uniq) | uniq -d
    fi
}

jirafy() {
    open "https://sencha.jira.com/browse/$1"
}

mcd() {
    mkdir -p "$1" && cd "$1"
}

# Remove by inode.
rmi() {
    for inode in "$@"; do
        find . -inum "$inode" -exec rm -rf {} \; 2> /dev/null
    done
}

# Open vim and immediately invoke CtrlP plugin.
vimp() {
    vim -c ":CtrlP"
}

webstart() {
	sudo python3 -m http.server 80 --cgi --bind 127.0.0.1
}

webstop() {
    ps ax | ag "[p|P]ython3? -m http.server" | sudo kill -9 $(cut -d" " -f2)
}

wifi_connect() {
    sudo iw dev wlan0 connect -w "$1"
    sudo dhclient wlan0
}

wifi_scan() {
    sudo iw dev wlan0 scan | ag SSID
}

