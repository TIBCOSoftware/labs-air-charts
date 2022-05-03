#!/bin/bash

network_type=${1:?}
# shellcheck disable=SC2034
os_type=${2:?}
arch_type=${3:?}

if [ -e functions.sh ]; then
    # shellcheck disable=SC1091
    . functions.sh
fi

build_offline(){
  # Offline artifacts
  pushd "./air-backend/installers/community/${arch_type}/air-backend" || exit 1
  ./export.sh || exit 1
  popd > /dev/null || exit 1
}

installer_target_path="dist"

if [ -d ${installer_target_path} ]; then
  rm -rf ${installer_target_path}
fi
mkdir -p ${installer_target_path} || exit 1


cp scripts/delete_* ${installer_target_path} || exit 1
cp scripts/install_* ${installer_target_path} || exit 1
cp scripts/functions.sh ${installer_target_path} || exit 1

# Docker compose artifacts
# Offline artifacts
if [[ "${network_type}" == "offline" ]];
then
  build_offline
fi
    
cp -r "./air-backend/installers/community/${arch_type}" "${installer_target_path}" || exit 1

cp scripts/start.sh ${installer_target_path} || exit 1
cp scripts/stop.sh ${installer_target_path} || exit 1