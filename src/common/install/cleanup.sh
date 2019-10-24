#!/usr/bin/env bash
set -e

echo "Cleaning apt cache"

apt-get clean -y
apt-get autoremove -y

rm -rf /var/lib/apt/lists/* /var/cache/apt/*
