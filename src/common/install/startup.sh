#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Add 'source generate_container_user' to .bashrc"

# have to be added to hold all env vars correctly
echo 'source $STARTUPDIR/generate_container_user' >> $HOME/.bashrc
