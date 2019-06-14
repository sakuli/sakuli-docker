#!/usr/bin/env bash
set -e

echo "Cleaning apt cache"

apt-get clean -y
apt-get autoremove -y
