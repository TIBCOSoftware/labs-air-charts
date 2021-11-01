@echo off
set release_name=%1

minikube addons disable ingress
minikube addons disable ingress-dns

helm delete %release_name%

Powershell.exe -Command "Get-DnsClientNrptRule | Where-Object {$_.Namespace -eq '.air'} | Remove-DnsClientNrptRule -Force;"