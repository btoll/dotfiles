# ccd – custom change directory
# a little something to make life easier
# position is a number in the stack, and
# can be obtained by running the following
# command: dirs -v
# pushd .
# pushd will load directories into the stack.
# popd will remove then and naturally
# dirs -v will list them.
function ccd() {
    position=$1
    if [ -z $position ]; then
        echo \\&quot;You need to specify the position of the directory in the stack\\&quot;
    else
        cd `dirs +$1 -l`
    fi
}

# mkdir and then immediately cd into it
function mcd() { mkdir -p "$1" && cd "$1"; }

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
