echo "Install Unity Hub" #custom install thingy so i dont get warning for uses the deprecated add-key method (which unity shows on their site)
sudo sh -c 'echo "deb https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'

wget -o- https://hub.unity3d.com/linux/keys/public
gpg --no-default-keyring --keyring ./unity_keyring.gpg --import public
gpg --no-default-keyring --keyring ./unity_keyring.gpg --export >./unity-archive-keyring.gpg
sudo mv ./unity-archive-keyring.gpg /etc/apt/trusted.gpg.d/

sudo apt update
sudo apt install unityhub -y

rm -f ./public
rm -f ./*.gpg*
echo ""

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
