#!/bin/bash

# Install the below packages to setup a vm for java development


# Install java

apt-get update && apt-get upgrade -y

apt install openjdk-8-jre-headless

sudo apt install openjdk-8-jdk


# Install docker

apt install apt-transport-https ca-certificates curl software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

apt update

apt-cache policy docker-ce

apt install docker-ce -y

systemctl status docker

# Run the below command manually at the end to login to docker hub
# docker login

# Install nodejs

sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -

apt-get install nodejs -y


# Install jhipster

npm install -g generator-jhipster

npm install -g yo@latest


# Install maven

apt install maven -y


