#!/bin/bash

if [ -e functions.sh ]; then
    # shellcheck disable=SC1091
    . functions.sh
fi

installer_target_path="dist"

if [ -d ${installer_target_path} ]; then
  rm -rf ${installer_target_path}
fi
mkdir -p ${installer_target_path} || exit 1

# Minikube artifacts
helm dependency update charts/air
cp -r charts/air ${installer_target_path} || exit 1
cp scripts/delete_* ${installer_target_path} || exit 1
cp scripts/install_* ${installer_target_path} || exit 1
cp scripts/functions.sh ${installer_target_path} || exit 1

# Docker compose artifacts
cp -r air-backend ${installer_target_path} || exit 1