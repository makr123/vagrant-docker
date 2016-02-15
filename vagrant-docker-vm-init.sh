#!/usr/bin/env bash

echo "Provision VM START"
echo "==================================="

#update in silence
sudo apt-get -y update

# Add locals to avoid "WARNING! Your environment specifies an invalid locale." notifications
sudo sh -c 'printf "LANGUAGE=\"en_US.UTF-8\"\nLC_ALL=\"en_US.UTF-8\"\n" >> /etc/default/locale'
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales

#install docker & use Docker as a non-root user
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

#install docker compose
sudo curl -sSLo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m`
sudo chmod +x /usr/local/bin/docker-compose

#install docker & docker compose autocompletion
curl -sSLo /etc/bash_completion.d/docker-compose https://raw.githubusercontent.com/docker/compose/$(docker-compose --version | awk 'NR==1{print $NF}')/contrib/completion/bash/docker-compose

echo "Provisioning done"
