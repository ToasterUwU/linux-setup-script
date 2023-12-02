echo "Installing RainbowMiner"
git clone "https://github.com/rainbowminer/RainbowMiner"

mkdir ./RainbowMiner/Config
mv ./rainbowminer_config.txt ./RainbowMiner/Config/config.txt

cd RainbowMiner
chmod +x *.sh
sudo ./install.sh

echo "vm.nr_hugepages=4096" | sudo tee -a /etc/sysctl.conf >/dev/null #needed for hugepages support

cd ~
sudo chmod -R 0777 RainbowMiner/ #litle fix since some things dont really set the right permissions
echo ""
