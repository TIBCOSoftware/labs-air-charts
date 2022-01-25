#!/usr/bin/env bash

if [ -e functions.sh ]; then
    # shellcheck disable=SC1091
    . functions.sh
fi

platform=$(getPlatform)

if [ "${platform}" = "darwin" ]; then
    release_name=${1:-myair}

    sudo rm -rf /etc/resolver/*-air
elif [ "${platform}" = "linux" ]; then
    resolver_file="/etc/resolvconf/resolv.conf.d/head"

    if [ -f "${resolver_file}" ]; then
        # Delete search entry
        sudo sed -i '/#labs-air/d' ${resolver_file}
        sudo resolvconf -u
    fi
fi

minikube addons disable ingress
checkError ${?} "Could not disable the minikube ingress"

minikube addons disable ingress-dns
checkError ${?} "Could not disable the minikube ingress-dns"

if ! helm delete "${release_name}" ; then
    echo "Could not remove the charts for ${release_name}"
fi

minikube stop
checkError ${?} "Could not stop minikube"

if [ "${AIR_MINIKUBE_DELETE:-true}" = "true" ]; then
    echo "Removing minikube. To retain it, set the environment variable AIR_MINIKUBE_DELETE to false"
    minikube delete
    checkError ${?} "Could not delete minikube"
fi