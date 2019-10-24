#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install openbox UI components"
apt-get update
apt-get install -y openbox obconf obmenu xterm x11-xkb-utils
apt-get purge -y pm-utils xscreensaver*
apt-get clean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/* /var/cache/apt/*
