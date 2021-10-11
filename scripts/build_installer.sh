#!/bin/bash

installer_target_path="dist"

if [ -d $installer_target_path ]; then
  rm -rf $installer_target_path
fi
mkdir -p $installer_target_path

helm dependency update charts/air
cp -r charts/air $installer_target_path
cp scripts/delete_minikube.sh $installer_target_path
cp scripts/install_minikube.sh $installer_target_path