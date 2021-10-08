#!/bin/sh

minikube start --driver=virtualbox --memory 4096 --cpus 2 --kubernetes-version v1.21.4

minikube addons enable ingress

minikube addons enable ingress-dns

minikube_ip=$(minikube ip)

sudo mkdir -p /etc/resolver
sudo echo "domain air
nameserver $minikube_ip
search_order 1
timeout 5" | sudo tee /etc/resolver/minikube-minikube-air  > /dev/null

release_name=$1

echo "Installing ${release_name}"

helm install ${release_name} ./ -f values-minikube.yaml
