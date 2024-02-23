#!/bin/bash

echo "Installing deps for OBS Virtual Cam"
sudo apt install v4l2loopback-dkms -y
echo ""

echo "Install libfuse to be able to use AppImages"
sudo apt install libfuse2 -y
echo ""

echo "Lower wait time for refind"
sudo sed -i "s/timeout 10/timeout 3/" /boot/efi/EFI/refind/refind.conf
echo ""