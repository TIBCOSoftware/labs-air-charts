#!/usr/bin/env bash

if [ -e functions.sh ]; then
    # shellcheck disable=SC1091
    . functions.sh
fi

platform=$(getPlatform)

minikube start --driver="${AIR_MINIKUBE_DRIVER:-hyperkit}" \
    --memory "${AIR_MINIKUBE_MEMORY:-4096}" \
    --cpus "${AIR_MINIKUBE_CPUS:-2}"

waitFor minikube 15

release_name=${1:-myair}

echo "Installing ${release_name}"

helm install "${release_name}" ./air -f air/values-minikube.yaml
checkError ${?} "Could not install the ${release_name} charts"

minikube addons enable ingress
checkError ${?} "Could not add ingress to minikube"

minikube addons enable ingress-dns
checkError ${?} "Could not add ingress-dns to minikube"

minikube_ip=$(minikube ip)

if [ "${platform}" = "darwin" ]; then

    sudo rm -rf /etc/resolver/*-air

    sudo mkdir -p /etc/resolver
    sudo echo "domain air
    nameserver ${minikube_ip}
    search_order 1
    timeout 5" | sudo tee /etc/resolver/minikube-minikube-air  > /dev/null

elif [ "${platform}" = "linux" ]; then

    resolver_file="/etc/resolvconf/resolv.conf.d/head"

    if [ -f "$resolver_file" ]; then
        # Delete search entry
        sudo sed -i '/#labs-air/d' ${resolver_file}
    fi

    sudo echo "search air #labs-air
    nameserver ${minikube_ip} #labs-air
    nameserver 8.8.8.8" | sudo tee /etc/resolvconf/resolv.conf.d/head  > /dev/null
    sudo resolvconf -u
fi
