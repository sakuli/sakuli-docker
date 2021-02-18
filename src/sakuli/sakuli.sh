#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Reloading $HOME/.bashrc"
source $HOME/.bashrc

echo "//registry.npmjs.org/:_authToken=$2" > $HOME/.npmrc
npm whoami

echo "Installing Sakuli v$1"
npm i -g -E @sakuli/cli@$1

echo "Installing Sakuli legacy v$1"
npm i -g -E @sakuli/legacy@$1

echo "Installing Sakuli legacy-types v$1"
npm i -g -E @sakuli/legacy-types@$1

forwarders=("gearman" "checkmk" "icinga2" "prometheus")
for fwd in "${forwarders[@]}"
do
    echo "Installing Sakuli forwarder $fwd v$1"
    npm i -g -E @sakuli/forwarder-$fwd@$1
done

echo "Installing Sakuli OCR v$1"
npm i -g -E @sakuli/ocr@$1

echo "Installing TypeScript v4.1.3"
npm i -g -E typescript@4.1.3

echo "Configuring .npmrc"
echo "//registry.npmjs.org/:_authToken=\${NPM_TOKEN}" > $HOME/.npmrc
