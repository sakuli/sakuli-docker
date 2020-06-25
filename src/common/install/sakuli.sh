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
npm i -g -E @sakuli/cli@$2

forwarders=("gearman" "checkmk" "icinga2" "prometheus")
for fwd in "${forwarders[@]}"
do
    echo "Installing Sakuli forwarder $fwd v$2"
    npm i -g -E @sakuli/forwarder-$fwd@$2
done

echo "Installing Typescript"
npm i -g -E typescript@3.9.5
echo "Installing sakuli legacy types"
npm i -g -E @sakuli/legacy-types@$2

echo "Configuring .npmrc"
echo "//registry.npmjs.org/:_authToken=\${NPM_TOKEN}" > $HOME/.npmrc
