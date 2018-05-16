#!/bin/bash

# This isn't working... can't figure out why yet.. :(

retries="10"
action="lock"
nullcmd="'which true'"

while getopts "lur:" opt; do
    case $opt in
        l ) action="lock"       ;;
        u ) action="unlock"     ;;
        r ) retries="$OPTARG"   ;;
    esac
done
shift $(($OPTIND - 1))
if [ $# -eq 0 ]; then
    cat <<EOF >&2
Usage: $0 [-l|-u] [-r retries] LOCKFILE
Where -l requests a lock (the default), -u requests an unlock, -r X
specifies a max number of retries before it fails (default = $retries).
EOF
    exit 1
fi
if [ -z "$(which lockfile | grep -v '^no ')" ]; then
    echo "$0 failed: 'lockfile' utility not found in PATH." >&2
    exit 1
fi

if [ "$action" = "lock" ]; then
    if ! lockfile -1 -r $retries "$1" 2> /dev/null; then
        echo "$0: Failed: Couldn't create lockfile in time." >&2
        exit 1
    fi
    rm -f "$1"
fi

exit 0