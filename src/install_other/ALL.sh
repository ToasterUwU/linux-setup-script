echo "Install ProtonMail Bridge"
wget "https://proton.me/download/bridge/protonmail-bridge_3.3.0-1_amd64.deb" -O ~/protonmail-bridge.deb
sudo apt install ~/protonmail-bridge.deb -y
rm -f ~/protonmail-bridge.deb
echo ""

echo "Installing Vesktop"
version=$(curl -sL https://api.github.com/repos/Vencord/Vesktop/releases/latest | jq -r ".tag_name" | sed 's/^v//')
download_url="https://github.com/Vencord/Vesktop/releases/download/v$version/VencordDesktop_${version}_amd64.deb"

wget "$download_url" -O ~/vesktop.deb

sudo dpkg -i ~/vesktop.deb
rm -f ~/vesktop.deb

timeout 30s vencorddesktop

sudo sed -i "s/Icon=vencorddesktop/Icon=discord/g" /usr/share/applications/vencorddesktop.desktop
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

echo "Installing ApplicationManager"
sudo apt install zsync -y
wget https://raw.githubusercontent.com/ivan-hc/AM-application-manager/main/INSTALL && chmod a+x ./INSTALL && sudo ./INSTALL && rm -f ./INSTALL
echo ""

echo "Installing Bitwarden"
am -i bitwarden
echo ""

echo "Installing Ledger Live"
am -i ledger-live-desktop
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash
echo ""

echo "Installing Microsoft Rewards Bot"
sudo apt install python3-tk python3-venv -y

sudo apt install google-chrome-stable -y

git clone "https://gitlab.com/farshadzargary1997/Microsoft-Rewards-bot"

cd Microsoft-Rewards-bot
python -m venv .venv
.venv/bin/pip install wheel
.venv/bin/pip install -r requirements.txt
cd ~

mv microsoft_rewards_bot_accounts.json ./Microsoft-Rewards-bot/accounts.json
mv start_microsoft_rewards_bot.sh ./Microsoft-Rewards-bot/start.sh
echo ""

echo "Installing Tdarr Node"
cd Tdarr

wget "https://f000.backblazeb2.com/file/tdarrs/versions/2.00.15/linux_x64/Tdarr_Updater.zip" -O ./updater.zip
unzip -o ./updater.zip
rm -f ./updater.zip

./Tdarr_Updater #install Tdarr Node (transcoder which works on job from Tdarr Server)
cd ~
echo ""
