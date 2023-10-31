echo "Installing dependencies"
sudo apt install -y unzip wget gnupg git curl python-is-python3 python3-pip
echo ""

echo "Installing Welcome App Packages"
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections #Accept ttf EULA automatically

sudo apt install ttf-mscorefonts-installer obs-studio kdenlive -y #install welcome apps
echo ""

echo "Installing Packages and Flatpaks"
sudo apt install -y nala youtubedl-gui qbittorrent thunderbird rpi-imager gnome-clocks docker docker-compose baobab                                                      # install packages i need
flatpak install -y spotify dev.geopjr.Collision org.onlyoffice.desktopeditors md.obsidian.Obsidian org.gnome.SimpleScan de.shorsh.discord-screenaudio com.ultimaker.cura # install flatpaks i need                                                                                                                                                    #update PATH to include pip installed things
pip install hyfetch --break-system-packages
echo ""
