echo "Installing dependencies"
sudo apt update
sudo apt install -y unzip wget gnupg git curl python-is-python3 python3-pip apt-transport-https
echo ""

echo "Installing Welcome App Packages"
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections #Accept ttf EULA automatically

sudo apt update
sudo apt install ttf-mscorefonts-installer obs-studio kdenlive -y #install welcome apps
echo ""

echo "Installing Packages and Flatpaks"
sudo apt update
sudo apt install -y nala youtubedl-gui qbittorrent thunderbird rpi-imager gnome-clocks docker.io docker-compose baobab handbrake-cli handbrake eddie-ui brave-browser # install packages i need
flatpak install -y spotify dev.geopjr.Collision org.onlyoffice.desktopeditors md.obsidian.Obsidian org.gnome.SimpleScan com.ultimaker.cura                         # install flatpaks i need                                                                                                                                                    #update PATH to include pip installed things
pip install hyfetch --break-system-packages
export PATH="$HOME/.local/bin:$PATH"
echo ""
