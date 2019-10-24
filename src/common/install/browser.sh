#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Chromium Browser"
apt-get update -y
apt-get install -y chromium-browser chromium-chromedriver chromium-browser-l10n chromium-codecs-ffmpeg
ln -s /usr/bin/chromium-browser /usr/bin/google-chrome
echo "CHROMIUM_FLAGS='--no-sandbox --user-data-dir'" > $HOME/.chromium-browser.init
echo "Install FireFox Browser"
apt-get install -y firefox firefox-geckodriver
apt-get clean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/* /var/cache/apt/*
