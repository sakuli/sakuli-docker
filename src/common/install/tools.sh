#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update
apt-get install -y build-essential wget locales libxtst-dev gnome-calculator xfce4-screenshooter git -y

echo "Generate locale for en_US.UTF-8"
locale-gen en_US.UTF-8
apt-get clean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/* /var/cache/apt/*
