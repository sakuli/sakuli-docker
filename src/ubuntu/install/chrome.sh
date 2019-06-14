#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Chromium Browser"
apt-get update -y
apt-get install -y chromium-browser=$1 chromium-browser-l10n=$1 chromium-codecs-ffmpeg=$1
ln -s /usr/bin/chromium-browser /usr/bin/google-chrome
### fix to start chromium in a Docker container, see https://github.com/ConSol/docker-headless-vnc-container/issues/2
echo "CHROMIUM_FLAGS='--no-sandbox --start-maximized --user-data-dir'" >$HOME/.chromium-browser.init
apt-get clean -y
apt-get autoremove -y
