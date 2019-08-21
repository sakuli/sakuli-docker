#!/bin/bash
set -e

source $HOME/.bashrc

echo -e "\n\n------------------ START SAKULI CONTAINER ---------------------------"

$STARTUPDIR/vnc_startup.sh echo "VNC ready!"
echo -e "\n\n------------------ VNC STARTUP finished -----------------------------"
echo "Executing: '$@'"

exec "$@"
