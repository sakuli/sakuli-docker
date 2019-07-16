#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Reloading $HOME/.bashrc"
source $HOME/.bashrc

echo "nvm use $1"
nvm use $1

echo "Installing Sakuli v$2"
npm i -g @sakuli/cli@$2

echo "Installing ChromeDriver v$3"
npm i -g chromedriver@$3

echo "Installing GeckoDriver v$4"
npm i -g geckodriver@$4

# The following step is currently required, since /usr/bin/env doesn't handle arguments properly on Linux.
# As @sakuli/cli contains the "#!/usr/bin/env node --no-warnings" shebang, it fails to start
# This temporary workaround updates the shebang line to mitigate this error
# echo "Patching Sakuli bin"
# sed -i '1s/.*/#!\/usr\/bin\/env node/' $HOME/.nvm/versions/node/v10.16.0/lib/node_modules/@sakuli/cli/dist/index.js
