#!/bin/bash

echo "Installing dependencies"
sudo apt update
sudo apt install -y unzip wget gnupg git curl python-is-python3 python3-pip apt-transport-https

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup.sh
chmod +x /tmp/rustup.sh
/tmp/rustup.sh -y
# shellcheck disable=SC1091
source "$HOME/.cargo/env"
echo ""

echo "Installing Welcome App Packages"
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections #Accept ttf EULA automatically

sudo apt update
sudo apt install ttf-mscorefonts-installer pika-gameutils-meta obs-studio kdenlive -y #install welcome apps
echo ""

echo "Installing Packages and Flatpaks"
sudo apt update
sudo apt install -y nala youtubedl-gui qbittorrent thunderbird rpi-imager gnome-clocks docker.io docker-compose baobab handbrake-cli handbrake eddie-ui brave-browser firefox virtualbox                                                                                                         # install packages i need
flatpak install -y spotify dev.geopjr.Collision org.onlyoffice.desktopeditors md.obsidian.Obsidian org.gnome.SimpleScan com.ultimaker.cura com.github.iwalton3.jellyfin-media-player com.github.micahflee.torbrowser-launcher org.freecadweb.FreeCAD camp.nook.nookdesktop com.bitwarden.desktop # install flatpaks i need                                                                                                                                                    #update PATH to include pip installed things
pip install -U git+https://github.com/hykilpikonna/hyfetch.git --break-system-packages
export PATH="$HOME/.local/bin:$PATH"
cargo install tealdeer
tldr --update
echo ""
