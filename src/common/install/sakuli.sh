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

echo "Installing Sakuli legacy v$2"
npm i -g @sakuli/legacy@$2

echo "Installing Sakuli legacy-types v$2"
npm i -g @sakuli/legacy-types@$2

forwarders=("gearman" "checkmk" "icinga2" "prometheus")
for fwd in "${forwarders[@]}"
do
    echo "Installing Sakuli forwarder $fwd v$2"
    npm i -g @sakuli/forwarder-$fwd@$2
done

echo "Installing TypeScript v3.8.3"
npm i -g -E typescript@3.8.3

echo "Configuring .npmrc"
echo "//registry.npmjs.org/:_authToken=\${NPM_TOKEN}" > $HOME/.npmrc
