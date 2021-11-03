#!/bin/sh

minikube start --driver=virtualbox --memory 4096 --cpus 2

sleep 15s

release_name=$1

echo "Installing ${release_name}"

helm install ${release_name} ./air -f air/values-minikube.yaml

minikube addons enable ingress

minikube addons enable ingress-dns

minikube_ip=$(minikube ip)

resolver_file="/etc/resolvconf/resolv.conf.d/head"

if [ -f "$resolver_file" ]; then
    # Delete search entry
    sudo sed -i '/#labs-air/d' $resolver_file
fi

sudo echo "search air #labs-air
nameserver $minikube_ip #labs-air
nameserver 8.8.8.8" | sudo tee /etc/resolvconf/resolv.conf.d/head  > /dev/null
sudo resolvconf -u



