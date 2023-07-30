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
sed -i "s/PLACEHOLDERWORKER/$HOSTNAME/g" ./RainbowMiner/Config/config.txt   #set miner name as hostname
sed -i "s/PLACEHOLDERPASSWORD/$PASSWORD/g" ./RainbowMiner/Config/config.txt #set password

cd RainbowMiner
chmod +x *.sh
sudo ./install.sh

echo "vm.nr_hugepages=4096" | sudo tee -a /etc/sysctl.conf >/dev/null #needed for hugepages support

cd ~
sudo chmod -R 0777 RainbowMiner/ #litle fix since some things dont really set the right permissions
echo ""

echo "Installing Tdarr Node"
cd Tdarr

wget "https://f000.backblazeb2.com/file/tdarrs/versions/2.00.15/linux_x64/Tdarr_Updater.zip" -O ./updater.zip
unzip -o ./updater.zip
rm -f ./updater.zip

./Tdarr_Updater #install Tdarr Node (transcoder which works on job from Tdarr Server)
cd ~
echo ""