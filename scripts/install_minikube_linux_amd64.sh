#!/bin/sh

minikube start --driver=virtualbox --memory 4096 --cpus 2

sleep 15s

release_name=$1

echo "Installing ${release_name}"

helm install ${release_name} ./air -f air/values-minikube.yaml

minikube addons enable ingress

minikube addons enable ingress-dns

minikube_ip=$(minikube ip)

sudo rm -rf /etc/resolvconf/resolv.conf.d/base

sudo echo "search air
nameserver $minikube_ip
timeout 5" | sudo tee /etc/resolvconf/resolv.conf.d/base  > /dev/null



