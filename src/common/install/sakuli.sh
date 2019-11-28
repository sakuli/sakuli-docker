#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Reloading $HOME/.bashrc"
source $HOME/.bashrc

echo "nvm use $1"
nvm use $1

echo "//registry.npmjs.org/:_authToken=$3" > $HOME/.npmrc
npm whoami

echo "Installing Sakuli v$2"
npm i -g @sakuli/cli@$2

forwarders=("gearman" "checkmk" "icinga2")
for fwd in "${forwarders[@]}"
do
    echo "Installing Sakuli forwarder $fwd v$2"
    npm i -g @sakuli/forwarder-$fwd@$2
done

echo "Configuring .npmrc"
echo "//registry.npmjs.org/:_authToken=\${NPM_TOKEN}" > $HOME/.npmrc
