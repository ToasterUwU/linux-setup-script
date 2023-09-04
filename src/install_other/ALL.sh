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

timeout 30s armcord

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

wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O chrome.deb
sudo apt install ./chrome.deb -y
rm -f chrome.deb

git clone "https://gitlab.com/farshadzargary1997/Microsoft-Rewards-bot"

cd Microsoft-Rewards-bot
python -m venv .venv
.venv/bin/pip install wheel
.venv/bin/pip install -r requirements.txt
cd ~

mv microsoft_rewards_bot_accounts.json ./Microsoft-Rewards-bot/accounts.json
mv start_microsoft_rewards_bot.sh ./Microsoft-Rewards-bot/start.sh
echo ""
