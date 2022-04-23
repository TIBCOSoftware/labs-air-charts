#!/bin/bash

docker-compose -p edgex down -v
network_type=${1:?}
os_type=${2:?}
arch_type=${3:?}

if [[ "${arch_type}" == "amd64" ]]; then
    pushd "./air-backend" > /dev/null || exit 1
    ./stop.sh || exit 2
    popd || exit 1
fi