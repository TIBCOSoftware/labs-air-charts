#!/bin/sh

release_name=$1

sudo rm -rf /etc/resolver/*-air

helm delete ${release_name}