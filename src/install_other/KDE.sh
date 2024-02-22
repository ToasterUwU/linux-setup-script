#!/bin/bash

echo "Install Wallpaper Engine KDE Plugin"
sudo apt install -y build-essential plasma-workspace-dev gstreamer1.0-libav liblz4-dev python3-websockets qtbase5-private-dev libqt5x11extras5-dev qml-module-qtwebchannel qml-module-qtwebsockets cmake
sudo apt -o Dpkg::Options::="--force-overwrite" install libmpv-dev -y
sudo apt install vulkan-sdk -y

# Download source
git clone https://github.com/catsout/wallpaper-engine-kde-plugin.git
cd wallpaper-engine-kde-plugin || exit

# Download submodule (glslang)
git submodule update --init

# Configure
# 'USE_PLASMAPKG=ON': using plasmapkg2 tool to install plugin
mkdir build && cd build || exit
cmake .. -DUSE_PLASMAPKG=ON

# Build
# shellcheck disable=SC2154
# shellcheck disable=SC2086
make -j$nproc

# Install package (ignore if USE_PLASMAPKG=OFF for system-wide installation)
make install_pkg
# install lib
sudo make install
echo ""

echo "Temp fix, because of package conflict"
sudo apt -y remove vulkan-sdk
sudo apt update
sudo apt --fix-broken install
echo ""