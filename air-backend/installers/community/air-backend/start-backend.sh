#!/bin/bash

# Check the exit status and report an error message
# Usage: checkError $? "custom message"
checkError() {
  [ "${1}" -ne 0 ] && echo "### ${2} See output above. Exit code: ${1}" && printStack && exit "${1}"
  return 0
}

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


