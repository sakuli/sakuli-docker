#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

function install {
    for pkg in $@
    do
        echo "Installing package $pkg"
        apt-get install -y $pkg
    done
}

apt-get update -y
apt-get upgrade -y
echo "===> Installing common tools"
install wget locales gnome-calculator xfce4-screenshooter git nitrogen rsync

echo "===> Installing libnss3-tool"
install libnss3-tools

echo "===> Installing nut.js dependencies"
install build-essential libxtst-dev

echo "===> Generate locale for en_US.UTF-8"
locale-gen en_US.UTF-8

echo "===> Installing TigerVNC"
wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz | tar xz --strip 1 --no-same-owner --no-same-permissions -C /

echo "===> Installing noVNC dependencies"
#used for websockify/novnc
install net-tools python-numpy

echo "===> Installing noVNC - HTML5 based VNC viewer"
mkdir -p $NO_VNC_HOME/utils/websockify
wget -qO- https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME
# use older version of websockify to prevent hanging connections on offline containers, see https://github.com/ConSol/docker-headless-vnc-container/issues/50
wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
chmod +x -v $NO_VNC_HOME/utils/*.sh
## create index.html to forward automatically to `vnc_lite.html`
ln -s $NO_VNC_HOME/vnc_lite.html $NO_VNC_HOME/index.html

echo "===> Installing Chromium Browser"
install chromium-browser chromium-chromedriver chromium-browser-l10n chromium-codecs-ffmpeg
ln -s /usr/bin/chromium-browser /usr/bin/google-chrome
echo "CHROMIUM_FLAGS='--no-sandbox --user-data-dir'" > $HOME/.chromium-browser.init
echo "===> Installing FireFox Browser"
install firefox firefox-geckodriver

echo "===> Installing OpenBox window manager"
install openbox obconf obmenu xterm x11-xkb-utils

echo "===> Installing nss-wrapper"
install libnss-wrapper gettext

echo "===> Cleaning up caches"
apt-get clean -y
apt-get autoremove -y
rm -rf /var/lib/apt/lists/* /var/cache/apt/*
