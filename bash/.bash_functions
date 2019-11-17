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

# Setup script boilerplate.
bp() {
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: bp <filename>"
    else
        # Let's not overwrite an existing file. `stat` and test the process exit code.
        stat "$1" &> /dev/null

	# Check exit code of `stat` call before proceeding.
	# An error (return value of 1 in this case) means that the file does not exist.
        if [ "$?" -eq 1 ]; then
            case "$1" in
                *.elm)  vim -c ":read ~/templates/elm.txt" "$1" ;;
                *.html) vim -c ":read ~/templates/html.txt" "$1" ;;
                *)      vim -c ":normal ibp" "$1" ;;
            esac
        else
            echo "$(tput setaf 3)[WARN]$(tput sgr0) File exists, aborting."
        fi
    fi
}

change_backlight() {
    echo "$1" >| /sys/class/backlight/intel_backlight/brightness
}

cpy() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: cpy <text_to_copy_to_clipboard>"
    else
        echo "$1" | xsel -b
    fi
}

# Deprecating this in favor of https://github.com/btoll/dump_describes node module.
# I'm leaving it here just for an example of a `sed` command.
#dump_describes() {
#    sed -n -E 's/^[[:space:]]{1,7}describe\('\(.*\)'/\1/p' "$1" | cut -d, -f1
#}

falloc() {
    if [ "$#" -lt 2 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: falloc <name> <size (ex. 1GB, 500MB)>"
    else
        NAME="$1"
        SIZE="$2"

        fallocate -l $SIZE $NAME
        sudo mkfs.ext3 $NAME
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

git_bootstrap() {
    cp $HOME/git_init/{COPYING,README.md} $(pwd)
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

            (
                cd "$ALIAS" > /dev/null
                git_hooks_install
            )
        fi
    fi
}

git_hooks_install() {
    if [ -z "$GITHOOKS" ]; then
        read -p "Location of git hooks (skip this step by exporting a \$GITHOOKS env var): " LOCATION

        GITHOOKS="$LOCATION"
    fi

    (
        cd .git/hooks
        rm -rf pre-commit pre-commit.d
        cp -r "$GITHOOKS"/* .
    )

    echo "$(tput setaf 2)[INFO]$(tput sgr0) Installed git hooks."
}

git_init() {
    git init
    git_hooks_install
    git_bootstrap
}

go_tmux() {
    SESSION=$(basename `pwd`)

    tmux has-session -t $SESSION 2> /dev/null

    if [ "$?" -eq 1 ]; then
        tmux new-session -s $SESSION -d
    fi

    tmux attach -t $SESSION
    clear
}

hexbits() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: hexbits <hexadecimal> [number of display bytes]"
        echo "For example: hexbits 0x646f67 2"
    else
        asbits `htoi "$1"` ${2:-4}
    fi
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

list_targets() {
    if [ "$#" -lt 1 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: list_targets <Makefile>"
    else
        sed -n 's/\(^[a-zA-Z-]*:\)/\1/p' "$1"
    fi
}

ls_scripts() {
    stat package.json &> /dev/null
    if [ "$?" -eq 1 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Directory does not contain \`package.json\`, aborting..."
    else
        awk '/"scripts": {/{flag=1; next} /}/{flag=0} flag' package.json | cut -d: -f1
    fi
}

mcd() {
    mkdir -p "$1" && cd "$1"
}

mnt_me() {
    if [ "$#" -lt 2 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: mnt_me <name> <mount point>"
    else
        NAME="$1"
        MNT="$2"

        lsmod | grep loop &> /dev/null

        # Add the loop device if not present.
        if [ $? -gt 0 ]; then
            sudo modprobe loop
        fi

        mkdir -p $MNT
        sudo mount -o loop $NAME $MNT
    fi
}

moby_dick() {
    # Well, sort of (apologies to John Bonham)...
    #
    # Let's ring the bell (BEL)!
    # `tput bel` or `echo -e "\a"` or `echo $'\a'` are all (mostly) equivalent.

    tput bel
    sleep .2
    tput bel
    sleep .2
    tput bel
    sleep .2
    tput bel

    sleep .4
    tput bel
    sleep .4
    tput bel
    sleep .4
    tput bel

    sleep .4
    tput bel
    sleep .2
    tput bel
    sleep .2
    tput bel
    sleep .2
    tput bel

    sleep 1
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

secure_browse() {
    # http://www.catonmat.net/blog/linux-socks5-proxy/
    #
    # -f - Requests ssh to go to background just before command execution.
    # -N - Do not execute a remote command.
    # -D - Specifies a local "dynamic" application-level port forwarding.
    #
    # Also, in FF make sure to set network.proxy.socks_remote_dns to true so DNS queries aren't leaked to the ISP.
    if [ $# -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: secure_browse <website_to_tunnel_traffic>"
    else
        ssh -f -N -D 1080 "$1"

        if [ $? -ne 0 ]; then
            echo "$(tput setaf 3)[WARN]$(tput sgr0) Could not establish tunnel"
        else
            firefox &> /dev/null &
        fi
    fi
}

sshp() {
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: sshp domain"
    else
        ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no "$1"
    fi
}

# Background a job to interrupt you, you hard worker!
take_a_break() {
    MINS="$1"
    s=

    if [ -z $MINS ]; then
        MINS=30
    fi

    if [ $MINS -ne 1 ]; then
        s=s
    fi

    echo "You're going to do something different in $MINS minute$s!"

    # Note that Bash shells must run the commands in a subshell!
    (
        # http://www.tldp.org/LDP/abs/html/arithexp.html
        sleep $((MINS * 60)) ;

        # If in an XSession use `xset`, else use `setterm` when in terminal.
        if [ -z $XTERM_SHELL ]; then
            setterm -blength 100 &> /dev/null ;
        else
            xset b on
        fi

        moby_dick ;

        # TODO: Set value of `b` back to what it was before rather than just turning it off.
        if [ -z $XTERM_SHELL ]; then
            setterm -blength 0
        else
            xset b off
        fi
    )&
}

# Specify the number of seconds to sleep before taking the screenshot.
# Increase the default of 5 seconds if more time is needed to prepare the screenshot.
take_screenshot() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: take_screenshot outfile [sleep=5]"
    else
        SECONDS=${2:-5}

        sleep "$SECONDS"
        xwd -root | convert - "$1"
        #xwd -root | xwdtopnm | pnmtopng > "$1"
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
    sudo iw dev wlp3s0 connect -w "$1" &> /dev/null
    sudo dhclient wlp3s0
}

wifi_scan() {
    sudo iw dev wlp3s0 scan | ag SSID
}

