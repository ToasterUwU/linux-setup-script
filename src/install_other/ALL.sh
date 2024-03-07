#!/bin/bash

echo "Install ProtonMail Bridge"
wget "https://proton.me/download/bridge/protonmail-bridge_3.9.1-1_amd64.deb" -O ~/protonmail-bridge.deb
sudo apt install ~/protonmail-bridge.deb -y
rm -f ~/protonmail-bridge.deb
echo ""

echo "Installing Vesktop"
version=$(curl -sL https://api.github.com/repos/Vencord/Vesktop/releases/latest | jq -r ".tag_name" | sed 's/^v//')
download_url="https://github.com/Vencord/Vesktop/releases/download/v$version/vesktop_${version}_amd64.deb"

wget "$download_url" -O ~/vesktop.deb

sudo dpkg -i ~/vesktop.deb
rm -f ~/vesktop.deb

timeout 30s vesktop

sudo sed -i "s/Icon=vesktop/Icon=discord/g" /usr/share/applications/vesktop.desktop
echo ""

echo "Installing Teamviewer"
wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" -O teamviewer.deb
sudo apt install ./teamviewer.deb -y
rm -f teamviewer.deb
echo ""

echo "Installing Angry IP Scanner"
version=$(curl -sL https://api.github.com/repos/angryip/ipscan/releases/latest | jq -r ".tag_name")
download_url="https://github.com/angryip/ipscan/releases/download/$version/ipscan_${version}_amd64.deb"

wget "$download_url" -O angry_ip_scanner.deb
sudo apt install ./angry_ip_scanner.deb -y
rm -f angry_ip_scanner.deb
echo ""

echo "Install Video DownloadHelper Companion"
wget "https://github.com/aclap-dev/vdhcoapp/releases/latest/download/vdhcoapp-linux-x86_64.deb" -O vdhcoapp.deb
sudo apt install ./vdhcoapp.deb -y
rm -f vdhcoapp.deb
echo ""

echo "Installing AppImageLauncher"
wget "https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb" -O appimagelauncher.deb
sudo apt install ./appimagelauncher.deb -y
rm -f appimagelauncher.deb
echo ""

echo "Installing Ledger Live"
wget "https://download.live.ledger.com/latest/linux" -O ~/Downloads/ledger-live-desktop.AppImage
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash
echo ""

echo "Installing Tdarr Node"
cd Tdarr || exit

wget "https://f000.backblazeb2.com/file/tdarrs/versions/2.00.15/linux_x64/Tdarr_Updater.zip" -O ./updater.zip
unzip -o ./updater.zip
rm -f ./updater.zip

./Tdarr_Updater #install Tdarr Node (transcoder which works on job from Tdarr Server)
cd ~ || exit
echo ""
