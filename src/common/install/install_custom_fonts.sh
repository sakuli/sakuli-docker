#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Installing ttf-wqy-zenhei"
apt-get update -y
apt-get install -y ttf-wqy-zenhei
apt-get clean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/* /var/cache/apt/*
