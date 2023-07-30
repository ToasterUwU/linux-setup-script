cd ~

echo "Install Brave"
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

xdg-settings set default-web-browser brave-browser.desktop
echo ""

echo "Installing AirVPNs Client Eddie"
curl -fsSL https://eddie.website/repository/keys/eddie_maintainer_gpg.key | sudo tee /usr/share/keyrings/eddie.website-keyring.asc >/dev/null
echo "deb [signed-by=/usr/share/keyrings/eddie.website-keyring.asc] http://eddie.website/repository/apt stable main" | sudo tee /etc/apt/sources.list.d/eddie.website.list

sudo apt update
sudo apt install eddie-ui -y
echo ""

echo "Install ProtonMail Bridge"
wget "https://proton.me/download/bridge/protonmail-bridge_3.3.0-1_amd64.deb" -O ~/protonmail-bridge.deb
sudo apt install ~/protonmail-bridge.deb -y
rm -f ~/protonmail-bridge.deb
echo ""

echo "Installing Armcord"
curl -fsSL https://eu.armcord.xyz/pgp-key.public | sudo gpg --dearmor -o /usr/share/keyrings/armcord.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/armcord.gpg] https://eu.armcord.xyz/apt-repo stable main" | sudo tee /etc/apt/sources.list.d/armcord.list
sudo apt update
sudo apt install armcord -y

sudo sed -i "s/Icon=armcord/Icon=discord/g" /usr/share/applications/armcord.desktop
echo ""

echo "Installing Teamviewer"
wget "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" -O teamviewer.deb
sudo apt install ./teamviewer.deb -y
rm -f teamviewer.deb
echo ""

echo "Installing Angry IP Scanner"
wget "https://github.com/angryip/ipscan/releases/download/3.9.0/ipscan_3.9.0_amd64.deb" -O angry_ip_scanner.deb
sudo apt install ./angry_ip_scanner.deb -y
rm -f angry_ip_scanner.deb
echo ""
cd ~

echo "Installing AppImage Launcher"
wget "https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb" -O appimage_launcher.deb
sudo apt install ./appimage_launcher.deb -y
rm -f appimage_launcher.deb
echo ""

echo "Installing Bitwarden"
wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -O ~/Downloads/bitwarden.AppImage

timeout 30s AppImageLauncher ~/Downloads/bitwarden.AppImage #open with AppImage launcher (prompt to integrate/install and run. No idea how to do this silently...)
echo ""

echo "Installing Ledger Live"
wget "https://download.live.ledger.com/latest/linux" -O ~/Downloads/ledger_live.AppImage
wget -q -O - "https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh" | sudo bash

timeout 30s AppImageLauncher ~/Downloads/ledger_live.AppImage #open with AppImage Launcher again
echo ""
