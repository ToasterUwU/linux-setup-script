#!/bin/bash

echo "Install Wallpaper Engine KDE Plugin"
sudo apt install -y build-essential libvulkan-dev plasma-workspace-dev gstreamer1.0-libav liblz4-dev libmpv-dev python3-websockets qtbase5-private-dev libqt5x11extras5-dev qml-module-qtwebchannel qml-module-qtwebsockets cmake vulkan-sdk

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
