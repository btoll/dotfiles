# Script dependencies.
. /usr/local/www/utils/fiddle.sh

bfind() {
    vim -p $(find "$1" -type f -name "$2")
}

bgrep() {
    vim -p "+/$1" $(grep -riIl "$1" "$2" | uniq)
}

intersect() {
    # http://askubuntu.com/a/472280
    if [ "$#" -eq 0 ]; then
        echo "Usage: FILE1 FILE2 [ REGEXP ]"
    else
        REGEXP=${3:-'\w* ?: ?((function)|(Ext.emptyFn)|(Ext.identityFn))'}
        sort <(egrep -o "$REGEXP" "$1" | cut -d: -f1 | sort | uniq) <(egrep -o "$REGEXP" "$2" | cut -d: -f1 | sort | uniq) | uniq -d
    fi
}

jirafy() {
    open "https://sencha.jira.com/browse/$1"
}

# mkdir and then immediately cd into it
mcd() {
    mkdir -p "$1" && cd "$1";
}

webify() {
    open "http://localhost/extjs/bugs/$1"
}
