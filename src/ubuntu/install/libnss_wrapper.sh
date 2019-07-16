#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install nss-wrapper to be able to execute image as non-root user"
apt-get update -y
apt-get install -y libnss-wrapper gettext
apt-get clean -y
apt-get autoremove -y
