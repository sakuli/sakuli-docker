#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

NVM_VERSION=$(curl -s https://github.com/nvm-sh/nvm/releases/latest | cut -f8 -d/ | cut -f1 -d\> | rev | cut -c2- | rev)
echo NVM_VERSION=$NVM_VERSION
wget -qO- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash

echo 'export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' > $HOME/.bashrc

echo "Reloading $HOME/.bashrc"
source $HOME/.bashrc

echo "nvm install $1"
nvm install $1
