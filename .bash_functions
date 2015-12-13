# http://fitnr.com/showing-a-bash-spinner.html
spinner() {
    local pid=$1
    local delay=0.2
    local spinstr='|/-\'

    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"

        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay

        printf "\b\b\b\b\b\b"
    done

    printf "    \b\b\b\b"
}

bfind() {
    vim -p $(find "$1" -type f -name "$2")
}

bgrep() {
    vim -p "+/$1" $(grep -riIl "$1" "$2" | uniq)
}

# Deprecating this in favor of https://github.com/btoll/dump_describes node module.
#dump_describes() {
#    sed -n -E 's/^[[:space:]]{1,7}describe\('\(.*\)'/\1/p' "$1" | cut -d, -f1
#}

# Remove by inode.
rmi() {
    for inode in "$@"; do
        find . -inum "$inode" -exec rm -rf {} \; 2> /dev/null
    done
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

sencha_bootstrap() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: sencha_bootstrap VERSION (either 4, 5 or 6)"
    else
        DIR=$([ "$1" -eq 4 ] && echo "extjs" || echo "ext")

        eval pushd '$SDK'"$1/$DIR"
        sencha ant bootstrap
        popd
    fi
}

webify() {
    open "http://localhost/extjs/bugs/$1"
}

wifi_connect() {
    sudo iw dev wlan0 connect -w "$1"
    sudo dhclient wlan0
}

