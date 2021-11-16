#!/bin/sh

release_name=${1:-myair}

resolver_file="/etc/resolvconf/resolv.conf.d/head"

if [ -f "$resolver_file" ]; then
    # Delete search entry
    sudo sed -i '/#labs-air/d' $resolver_file
    sudo resolvconf -u
fi

minikube addons disable ingress
minikube addons disable ingress-dns

helm delete ${release_name}
