#!/bin/bash

echo "Install Envision"
sudo apt update
sudo apt install -y libgtk-4-dev libadwaita-1-dev libssl-dev libjxl-dev libvte-2.91-gtk4-dev meson ninja-build git desktop-file-utils gettext file libusb-dev libusb-1.0-0-dev curl libeigen3-dev glslang-tools glslc

sudo apt install -y build-essential pkg-config cmake libstdc++-12-dev libxkbcommon-dev fontconfig libfontconfig-dev libdbus-1-dev libasound2-dev python3 libopenvr-dev libopenvr-api1 libopenxr-dev libpipewire-0.3-0 libpipewire-0.3-dev libspa-0.2-dev clang
git clone https://github.com/galister/wlx-overlay-s.git
cd wlx-overlay-s || exit
cargo install --path .
cd ..
rm -rf wlx-overlay-s

git clone https://gitlab.com/gabmus/envision/
cd envision || exit
meson setup build -Dprefix="$PWD/build/localprefix" -Dprofile=development
ninja -C build
ninja -C build install

sudo cp build/localprefix/bin/envision /bin/
sudo cp -r build/localprefix/share/* /usr/share/

cd ..
rm -rf envision
echo ""
