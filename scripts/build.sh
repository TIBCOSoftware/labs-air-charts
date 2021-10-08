#!/bin/bash

destination=$1

mkdir -p dist
helm dependency update charts/air
cp -r charts/air ${destination}
cp scripts/delete_minikube.sh ${destination}
cp scripts/install_minikube.sh ${destination}