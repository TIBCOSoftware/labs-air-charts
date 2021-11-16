@echo off

set driver_name=%AIR_MINIKUBE_DRIVER%

if "%driver_name%"=="" set driver_name=hyperv

minikube start --driver=%driver_name%  --memory 4096 --cpus 2  

timeout 15

set release_name=%1

if "%release_name%"=="" set release_name=myair

echo "Installing %release_name%"

helm install %release_name% ./air -f air/values-minikube.yaml

minikube addons enable ingress

minikube addons enable ingress-dns

Powershell.exe -Command "Get-DnsClientNrptRule | Where-Object {$_.Namespace -eq '.air'} | Remove-DnsClientNrptRule -Force; Add-DnsClientNrptRule -Namespace \".air\" -NameServers \"$(minikube ip)\""