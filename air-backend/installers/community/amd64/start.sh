#!/bin/bash

if [ -e ../functions.sh ]; then
    # shellcheck disable=SC1091
    . ../functions.sh
fi

docker-compose rm -f
checkError $? "Could not remove composed environment"

docker-compose up -d
checkError $? "Could not compose the docker environment"
