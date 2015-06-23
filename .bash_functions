bfind() {
    vim -p $(find "$1" -type f -name "$2")
}

bgrep() {
    vim -p "+/$1" $(grep -riIl "$1" "$2" | uniq)
}

dump_describes() {
    sed -n -E 's/^[[:space:]]{1,7}describe\('\(.*\)'/\1/p' "$1" | cut -d, -f1
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
        echo "Usage: sencha_bootstrap VERSION (either 5 or 6)"
    else
        eval pushd '$SDK'"$1"'/ext'
        sencha ant bootstrap
        popd
    fi
}

webify() {
    open "http://localhost/extjs/bugs/$1"
}

