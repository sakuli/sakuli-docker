#!/usr/bin/env bash
set -e

echo "Install Firefox v$1"
apt-get update -y
apt-get install -y firefox=$1 firefox-geckodriver=$1
apt-get clean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
