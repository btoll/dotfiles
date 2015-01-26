bfind() {
    vim -p $(find "$1" -type f -name "$2")
}

bgrep() {
    vim -p "+/$1" $(grep -riIl "$1" "$2" | uniq)
}

# ccd – custom change directory
# a little something to make life easier
# position is a number in the stack, and
# can be obtained by running the following
# command: dirs -v
# pushd .
# pushd will load directories into the stack.
# popd will remove then and naturally
# dirs -v will list them.
ccd() {
    position=$1
    if [ -z $position ]; then
        echo \\&quot;You need to specify the position of the directory in the stack\\&quot;
    else
        cd `dirs +$1 -l`
    fi
}

# mkdir and then immediately cd into it
mcd() {
    mkdir -p "$1" && cd "$1";
}

# cd up ..n dirs
# NOTE `cd -` doesn't do as you expect if you `.. 6` and then `cd -`
#function ..() {
#    local levels=$1
#    while ((levels > 0)); do
#        cd .. || break
#        #let 'levels-'
#	let "levels=levels-1"
#    done
#}
