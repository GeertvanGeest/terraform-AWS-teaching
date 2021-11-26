#!/usr/bin/env bash

# stdout en stderr in /var/log/cloud-init-output.log

# sudo apt-get update -y
# sudo apt-get install -y figlet

sudo su - ubuntu

cd /home/ubuntu
git clone https://github.com/GeertvanGeest/AWS-docker.git
