# This page includes all troubleshooting commands needed to fix issues in kubernetes cluster

## Pod cant reach api server

If the pod cant query api server or if any app tries to execute "get" call on any resource
and the socket connection times out then it means pod cant reach the api server.
Run the below commands

```
systemctl stop kubelet
systemctl stop docker
iptables --flush
iptables -tnat --flush
systemctl start kubelet
systemctl start docker
```

## Nginx Ingress controller pod wont start

You need to change some parameteers in nginx deployment

```
kubectl -n ingress-nginx edit deploy nginx-ingress-controller

dnsPolicy: Default
hostNetwork: true
```
