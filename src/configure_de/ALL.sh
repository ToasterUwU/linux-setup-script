#!/bin/bash

echo "Setting default Browser to Firefox"
xdg-settings set default-web-browser firefox.desktop
echo ""

echo "Change refind config"
sudo sed -i "s/timeout 20/timeout 3/g" /boot/efi/EFI/refind/refind.conf
sudo sed -i 's/#default_selection "+,bzImage,vmlinuz"/default_selection "vmlinuz,bzImage"/g' /boot/efi/EFI/refind/refind.conf
echo ""
