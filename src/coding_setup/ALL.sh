echo "Git Config"
git config --global user.name ToasterUwU
git config --global user.email aki@toasteruwu.com
echo ""

echo "Setting Up the Discord Bot Template"
git clone https://github.com/ToasterUwU/discord-bot-base /home/aki/Desktop/Code/discord_bots/.base
echo ""

echo "Install Rust Lang" #not one liner so i can tell it to not prompt me
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o "rustup-init.sh"
bash rustup-init.sh -y
rm rustup-init.sh
echo ""

echo "Install Python Packages"
sudo apt install -y python3-venv
export PATH="$HOME/.local/bin:$PATH"
echo ""

echo "Installing NodeJS"
sudo apt install -y npm nodejs
echo ""

echo "Installing VSCode"
sudo apt install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y
echo ""

echo "Install other Packages needed"
sudo apt install -y fonts-firacode
echo ""
