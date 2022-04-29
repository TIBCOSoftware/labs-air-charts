#!/bin/bash

network_type=${1:?}
os_type=${2:?}
arch_type=${3:?}

if [ -e functions.sh ]; then
    # shellcheck disable=SC1091
    . functions.sh
fi

build_offline(){
  # Offline artifacts
  if [[ "${arch_type}" == "amd64" ]]; then
      pushd ./air-backend/installers/community/amd64 || exit 1
      ./export.sh || exit 1
      popd > /dev/null || exit 1
  elif [[ "${arch_type}" == "arm64" ]]; then
      pushd ./air-backend/installers/community/arm64 || exit 1
      ./export.sh || exit 1
      popd > /dev/null || exit 1
  fi
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

if [[ "${arch_type}" == "amd64" ]]; then
    cp -r ./air-backend/installers/community/amd64 ${installer_target_path} || exit 1
elif [[ "${arch_type}" == "arm64" ]]; then
    cp -r ./air-backend/installers/community/arm64 ${installer_target_path} || exit 1
fi

cp scripts/start.sh ${installer_target_path} || exit 1
cp scripts/stop.sh ${installer_target_path} || exit 1