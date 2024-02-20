#!/bin/bash

echo "Install Envision"
sudo apt update
sudo apt install -y libgtk-4-dev libadwaita-1-dev libssl-dev libjxl-dev libvte-2.91-gtk4-dev meson ninja-build git desktop-file-utils gettext file libusb-dev libusb-1.0-0-dev curl
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup.sh
chmod +x /tmp/rustup.sh
/tmp/rustup.sh -y
# shellcheck disable=SC1091
source "$HOME/.cargo/env"

sudo apt install libopenvr-dev -y
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
