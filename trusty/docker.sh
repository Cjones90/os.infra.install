#!/bin/bash

# Remove old ones
sudo apt-get remove docker docker-engine

# Check if trusty
VER=$(lsb_release -a | grep Release | awk '{print $2'})

# If trusty
if [[ $VER = '14.04' ]]; then
    sudo apt-get update

    sudo apt-get install -y \
        linux-image-extra-$(uname -r) \
        linux-image-extra-virtual
fi

# Prereq
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Get GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add apt
DOCKER_REPO=$(grep https://download.docker.com/linux/ubuntu < /etc/apt/sources.list)
if [[ -z $DOCKER_REPO ]]; then
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
fi

sudo apt-get update

sudo apt-get install -y docker-ce

# Add user to docker group (so no sudo needed for docker commands)
sudo usermod -aG docker $USER

# Enable docker on boot if 16.04
if [[ $VER = '16.04' ]]; then
    sudo systemctl enable docker
fi

# Install Docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /tmp/docker-compose
chmod +x /tmp/docker-compose && sudo cp /tmp/docker-compose /usr/local/bin/docker-compose && rm /tmp/docker-compose
