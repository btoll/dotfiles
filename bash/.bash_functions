bag() {
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: bag <pattern> [<search_dir>]"
    else
        STARTSEARCH="$2"
        vim "+/$1" $(ag -ilw "$1" ${STARTSEARCH:="."} | uniq)
    fi
}

bfind() {
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: bfind <pattern> [<search_dir>]"
    else
        STARTSEARCH="$2"
        # http://blog.sanctum.geek.nz/unix-as-ide-files/
        #
        #   "You can use + as the terminating character instead if you want to put all
        #    of the results on one invocation of the command. One trick I find myself
        #    using often is using find to generate lists of files that I then edit in
        #    vertically split Vim windows"
        #
        find ${STARTSEARCH:="."} -type f -name "$1" -exec vim {} +
    fi
}

bgrep() {
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: bgrep <pattern> [<root_dir>]"
    else
        STARTSEARCH="$2"
        vim "+/$1" $(grep -riIl "$1" ${STARTSEARCH:="."} | uniq)
    fi
}

# Deprecating this in favor of https://github.com/btoll/dump_describes node module.
#dump_describes() {
#    sed -n -E 's/^[[:space:]]{1,7}describe\('\(.*\)'/\1/p' "$1" | cut -d, -f1
#}

# Setup script boilerplate.
bp() {
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: bp <filename>"
    else
        vim -c ":normal ibp" "$1"
    fi
}

cdl() {
    if [ -z "$1" ]; then
        echo "Usage: cdl <DIR>"
    else
        cd "$1" && ls -l
    fi
}

cla() {
    if [ -n "$1" ]; then
        clear
        echo "$(tput setab 7)$(tput setaf 4)Listing $(tput bold)$1$(tput sgr0)"
        ls -lAhF "${1}"
    else
        clear && ls -lAhF
    fi
}

cll() {
    if [ -n "$1" ]; then
        clear
        echo "$(tput setab 7)$(tput setaf 4)Listing $(tput bold)$1$(tput sgr0)"
        ls -lhF "${1}"
    else
        clear && ls -lhF
    fi
}

cls() {
    if [ -n "$1" ]; then
        clear
        echo "$(tput setab 7)$(tput setaf 4)Listing $(tput bold)$1$(tput sgr0)"
        ls "${1}"
    else
        clear && ls
    fi
}

get_code_point() {
    if [ -z "$1" ]; then
        echo "Usage: get_code_point <char>"
    else
        # -A = Specify the input address base (n == no address)
        # -t = Specify the output format (d == signed decimal, 4 == four bytes)
        printf "$1" | od -A n -t d4
    fi
}

git_clone() {
    URL="$1"
    ALIAS="$2"
    BASE=

    if [ -z "$URL" ]; then
        echo "Usage: git_clone <REPO> [<ALIAS>]"
    else
        if [ -z "$ALIAS" ]; then
            git clone "$URL"
        else
            git clone "$URL" "$ALIAS"
        fi

        if [ $? -eq 0 ]; then
            # Will match:
            #
            #       https://github.com/btoll/dotfiles.git
            #       or
            #       git@github.com:btoll/dotfiles.git
            #       or
            #       git+https://github.com/btoll/dotfiles
            #
            # and capture only `dotfiles`.
            if [ -z "$ALIAS" ]; then
                BASE=$([[ "$URL" = *.* ]] && basename "$URL" || echo "")
                # Remove the `.git` extension.
                ALIAS=${BASE%.git}
            fi

            echo "$(tput setaf 2)[INFO]$(tput sgr0) Cloned into ./$ALIAS/"

            pushd "$ALIAS" > /dev/null
            git_hooks_install
            popd > /dev/null
        fi
    fi
}

git_hooks_install() {
    if [ -z "$GITHOOKS" ]; then
        read -p "Location of git hooks (skip this step by exporting a \$GITHOOKS env var): " LOCATION

        GITHOOKS="$LOCATION"
    fi

    pushd .git/hooks > /dev/null
    rm -rf pre-commit pre-commit.d
    cp -r "$GITHOOKS"/* .
    popd > /dev/null

    echo "$(tput setaf 2)[INFO]$(tput sgr0) Installed git hooks."
}

git_init() {
    git init
    git_hooks_install
}

go_tmux() {
    SESSION=$(basename `pwd`)

    tmux has-session -t $SESSION 2> /dev/null

    if [ "$?" -eq 1 ]; then
        tmux new-session -s $SESSION -d
    fi

    tmux attach -t $SESSION
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
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: rmi file [file ...]"
    else
        for FILE in "$@"; do
            INODE=$(ls -i "$FILE" | cut -f1 -d" ")
            find . -inum $INODE -exec rm -rf {} \; 2> /dev/null
        done
    fi
}

# Open vim and immediately invoke CtrlP plugin.
vimp() {
    vim -c ":CtrlP"
}

#web_start() {
#    sudo python3 -m http.server 80 --cgi --bind 127.0.0.1
#}
#
#web_stop() {
#    ps ax | ag "[p|P]ython3? -m http.server" | sudo kill -9 $(cut -d" " -f2)
#}

wifi_connect() {
    sudo iw dev wlan0 connect -w "$1"
    sudo dhclient wlan0
}

wifi_scan() {
    sudo iw dev wlan0 scan | ag SSID
}

