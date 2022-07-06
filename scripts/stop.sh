#!/bin/bash

# shellcheck disable=SC2034
network_type=${1:?}
# shellcheck disable=SC2034
os_type=${2:?}
arch_type=${3:?}

pushd "./air-backend" > /dev/null || exit 1
./stop.sh ${arch_type}
popd || exit 1