#!/bin/bash

network_type=${1:?}
# shellcheck disable=SC2034
os_type=${2:?}
arch_type=${3:?}
release_version=${4:?}

if [ -e functions.sh ]; then
    # shellcheck disable=SC1091
    . functions.sh
fi

replace_release_version(){
  # Replace release version
  sed -i  "s/LABS_AIR_VERSION=GENERATED_VERSION/LABS_AIR_VERSION=${release_version}/" "${installer_target_path}/air-backend/.env"
}

build_offline(){
  # Offline artifacts
  pushd "./air-backend/installers/community/air-backend" || exit 1
  ./export.sh ${arch_type} || exit 1
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
    
cp -r "./air-backend/installers/community" "${installer_target_path}" || exit 1

replace_release_version

cp scripts/start.sh ${installer_target_path} || exit 1
cp scripts/stop.sh ${installer_target_path} || exit 1