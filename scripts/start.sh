#!/bin/bash

network_type=${1:?}
os_type=${2:?}
arch_type=${3:?}

load_offline() {
    if [[ "${arch_type}" == "amd64" ]]; then
        pushd ./${arch_type}/air-backend > /dev/null || exit 1
        ./load.sh || exit 2
        popd || exit 1
    fi
}

start(){
    if [[ "${arch_type}" == "amd64" ]]; then
        pushd ./${arch_type}/air-backend > /dev/null || exit 1
        ./start.sh || exit 2
        popd || exit 1
    fi
}

if [[ "${network_type}" == "offline" ]]; then
      load_offline || exit 1
fi

start

