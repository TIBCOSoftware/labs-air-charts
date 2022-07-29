#!/bin/bash

if [ -e ../functions.sh ]; then
    # shellcheck disable=SC1091
    . ../functions.sh
fi

if [ -n "$1" ]; then
    case "$1" in
    arm64)
    export ARCH=-$1
    ;;
    amd64)
    export ARCH=""
    ;;
    esac
else
	export ARCH=""
fi

docker-compose rm -f
checkError $? "Could not remove composed environment"

docker-compose up -d
checkError $? "Could not compose the docker environment"
