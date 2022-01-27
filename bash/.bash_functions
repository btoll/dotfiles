bag() {
    if [ "$#" -eq 0 ]; then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: bag <pattern> [<search_dir>]"
    else
        STARTSEARCH="$2"
        vim "+/$1" $(ag -ilw "$1" ${STARTSEARCH:="."} | uniq)
    fi
}

beep() {
    local pid
    (
        ( speaker-test -t sine -f 1000 )& pid=$! \
        && sleep 0.1s \
        && kill -9 "$pid"
    ) > /dev/null
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
        find ${STARTSEARCH:="."} -type f -name "$1" -exec vim {} + 2> /dev/null
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
        # Check exit code of `stat` call before proceeding.
        # An error (return value of 1 in this case) means that the file does not exist.
        if ! stat "$1" &> /dev/null
        then
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

dim_screen() {
    # Run `xrandr` to get attached screens.
    local value="$1"
    if [ "$#" -eq 0 ]
    then
        echo "Usage: dim_screen [0 < value <= 1]"
    else
        xrandr --output eDP-1 --brightness "$value"
    fi
}

dpkg_search() {
    local package="$1"
    local state="$2"

    if [ -z "$package" ] || [ -z "$state" ]
    then
        echo "[Usage] dpkg_search PACKAGE STATE"
    else
        for log in $(ls /var/log/dpkg*)
        do
            local re='\b'"$state"'\b.*'"$package"''
            local res="$(zgrep -E $re $log)"

            if [ "$res" = "" ]
            then
                echo "$(tput setaf 1)[No match]$(tput sgr0) $log"
            else
                echo "$(tput setaf 2)[Match]$(tput sgr0) $log"
                echo "$res"
            fi
        done
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

# `ff` for "fuzzy find"!
ff() {
    local projects_dir
    projects_dir=${1:-/srv/projects}
    dir=$(find "$projects_dir" -type d -not -path '*/\.*' -maxdepth 10 2> /dev/null | fzf)
    cd $dir
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
    local project_name="$1"

    if cp "$HOME"/dotfiles/bootstrap/{COPYING,README.md} . 2> /dev/null
    then
        echo "$(tput setaf 2)[INFO]$(tput sgr0) Installed bootstrap files into project root."
        if [ -n "$" ]
        then
            sed -i 's/PROJECT_NAME/'"$project_name"'/' README.md
        fi
    else
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Could not install bootstrap files."
    fi
}

git_clone() {
    local git_repo="$1"
    local git_alias="$2"
    local base
    local should_install

    if [ -z "$git_repo" ]
    then
        echo "Usage: git_clone <git_repo> [ <git_alias> ]"
    else
        if [ -z "$git_alias" ]
        then
            # This will match:
            #
            #    https://github.com/btoll/dotfiles.git
            #    or
            #    git@github.com:btoll/dotfiles.git
            #    or
            #    git+https://github.com/btoll/dotfiles
            #
            # and capture only `dotfiles`.
            base=$([[ "$git_repo" = *.* ]] && basename "$git_repo" || echo "")
            # Remove the `.git` extension.
            git_alias="${base%.git}"
        fi

        if git clone "$git_repo" "$git_alias" 2> /dev/null
        then
            echo "$(tput setaf 2)[INFO]$(tput sgr0) Cloned into ./$git_alias/"

            read -p "Install git hooks? [y|N]: " should_install

            if [ "$should_install" = y ] || [ "$should_install" = Y ]
            then
                # Don't change into another dir w/o user permission!
                # Do this in a subshell for now.
                (
                    cd "$git_alias" ;
                    git_hooks_install
                )
            else
                echo "[INFO] Git hooks not installed."
            fi
        else
            echo "$(tput setaf 1)[ERROR]$(tput sgr0) The \`$git_repo\` repository could not be cloned."
        fi
    fi
}

git_hooks_install() {
    local location
    local githooks="$GITHOOKS"

    if [ -z "$githooks" ]
    then
        read -p "Location of git hooks (skip this step by exporting a \$GITHOOKS env var) [$HOME/dotfiles/git-hub/hooks]: " location

        # Capture ENTER key.
        if [ "$location" = "" ]
        then
            location="$HOME/dotfiles/git-hub/hooks"
        fi

        githooks="$location"
    fi

    rm -rf .git/hooks/pre-commit*

    if cp -r "$githooks"/* .git/hooks 2> /dev/null
    then
        echo "$(tput setaf 2)[INFO]$(tput sgr0) Installed Git hooks into \`./git/hooks\`."
    else
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Could not install Git hooks."
    fi
}

git_init() {
    git init
    git_bootstrap "$1"
    git_hooks_install
}

go_tmux() {
    SESSION=$(basename `pwd`)

    if ! tmux has-session -t "$SESSION" 2> /dev/null
    then
        tmux new-session -s "$SESSION" -d
    fi

    tmux attach -t "$SESSION"
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

h() {
    if [ "$#" -eq 0 ]; then
        echo "Usage: h <search_string>"
        echo "For example: h foobar"
    else
        history | ag "$1"
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
    # After much fiddling around because I couldn't get the beep to work,
    # I'm using the `speaker-test` binary that is part of `alsa`:
    # https://unix.stackexchange.com/a/163716

    beep
    sleep .2
    beep
    sleep .2
    beep
    sleep .2
    beep

    sleep .4
    beep
    sleep .4
    beep
    sleep .4
    beep

    sleep .4
    beep
    sleep .2
    beep
    sleep .2
    beep
    sleep .2
    beep

    sleep 1
}

# First and only argument is the profile, defaults to "default".
parse_aws_creds() {
    local creds
    local account="${1:-default}"
    local profile_dir="$HOME/aws-access-keys/$account"

    if [ ! -d  "$profile_dir" ]
    then
        echo "[ERROR] Profile \`$account\` does not exist!"
    else
        creds=$(< "$profile_dir/accessKeys.csv" tail -1)
        echo "export AWS_ACCESS_KEY_ID="$(echo $creds | awk -F, '{ print $1 }')
        echo "export AWS_SECRET_ACCESS_KEY="$(echo $creds | awk -F, '{ print $2 }')
    fi
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

rmi_images() {
    for image in $(docker images | tail -n +2 | awk '{print $3}')
    do
        docker rmi -f "$image"
    done
}

rmi_images_by_name() {
    local name
    name="$1"

    if [ -z "$name" ]
    then
        echo "$(tput setaf 1)[ERROR]$(tput sgr0) Not enough arguments."
        echo "Usage: rmi_images_by_name name"
    fi

    docker images -a | ag "$name" | awk '{print $3}' | xargs docker rmi
}

rm_containers() {
    docker container rm $(docker container ls -aq)
}

rm_volumes() {
    docker volume rm $(docker volume ls --quiet)
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

shaq() {
    echo -e "It's supposed to be 1-2-3, not 1-2 back to 1.\nhttps://www.youtube.com/watch?v=y44DaWQH8-0"
}

# Background a job to interrupt you, you hard worker!
take_a_break() {
    local mins="$1"
    local s="s"

    if [ -z "$mins" ]
    then
        mins=30
    fi

    if [ "$mins" -eq 1 ]
    then
        s=
    fi

    echo "You're going to do something different in $mins minute$s!"

    # Note that Bash shells must run the commands in a subshell!
    (
        # http://www.tldp.org/LDP/abs/html/arithexp.html
        sleep "$((mins * 60))" ;

        # If in an XSession use `xset`, else use `setterm` when in terminal.
#        if [ -z $XTERM_SHELL ]; then
#            setterm -blength 100 &> /dev/null ;
#        else
#            xset b on
#        fi

        moby_dick ;

        # TODO: Set value of `b` back to what it was before rather than just turning it off.
#        if [ -z $XTERM_SHELL ]; then
#            setterm -blength 0
#        else
#            xset b off
#        fi
    )&
}

# Specify the number of seconds to sleep before taking the screenshot.
# Increase the default of 5 seconds if more time is needed to prepare the screenshot.
# If imagemagick doesn't work, see this https://how-2-take-a-screenshot.com/ubuntu-linux/.
#
# The following takes a partial screenshot.  After invoking it, go to the window and drag
# the mouse to get the desired screenshot.
#
#       import filename.png
#
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

toggle_sound() {
    amixer sset Master unmute
    amixer sset Headphone unmute
    amixer sset Speaker unmute
}

# Open vim and immediately invoke CtrlP plugin.
vimp() {
    vim -c ":CtrlP"
}

wifi_connect() {
    sudo iw dev wlp2s0 connect -w "$1" &> /dev/null
    sudo dhclient wlp2s0
}

wifi_scan() {
    sudo iw dev wlp2s0 scan | ag SSID
}

