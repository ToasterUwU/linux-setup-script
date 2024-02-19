#!/bin/bash

echo "Install Envision"
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
