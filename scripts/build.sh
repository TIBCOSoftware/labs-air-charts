#!/bin/bash

mkdir -p dist
helm dependency update charts/air
cp -r charts/air dist/
cp scripts/delete_minikube.sh dist/
cp scripts/install_minikube.sh dist/