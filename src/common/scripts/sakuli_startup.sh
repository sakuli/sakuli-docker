#!/bin/bash
set -e

source $HOME/.bashrc

echo -e "\n\n------------------ START SAKULI CONTAINER ---------------------------"
$STARTUPDIR/vnc_startup.sh "$@"
