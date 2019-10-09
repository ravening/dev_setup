# Minikube Ubuntu


## Installing minikube on ubuntu

```bash
sudo apt-get update
sudo apt-get install apt-transport-https
sudo apt-get upgrade -y
```


## Install kvm

```bash
sudo apt-get -y install qemu-kvm libvirt-bin virt-top  libguestfs-tools virtinst bridge-utils
sudo modprobe vhost_net
sudo lsmod | grep vhost
echo "vhost_net" | sudo tee -a /etc/modules
```


## Install docker

```bash
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install docker-ce
```


## Install minikube

```bash
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl  /usr/local/bin/


curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2
chmod +x docker-machine-driver-kvm2
sudo mv docker-machine-driver-kvm2 /usr/local/bin/
```

## Install socat
```bash
apt install socat
```

## If you are running minkube on VM, run below command

```bash
minikube start --vm-driver=none
```


## If you are running minikube on Ubuntu machine

```bash
minikube start --vm-driver kvm2
```

kubectl create secret generic regcred --from-file=.dockerconfigjson=/root/.docker/config.json --type=kubernetes.io/dockerconfigjson

kubectl get secret regcred --output=yaml