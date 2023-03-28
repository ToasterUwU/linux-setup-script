#!/bin/bash

# Disable screen turning off and locking while script runs
echo "Disabling Screenlock until done"
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
gsettings set org.gnome.desktop.screensaver lock-enabled false
echo ""

# Get Password
read -sp "Password please: " PASSWORD # Get password that i use for all internal things and for my password managers (SSH to all my VMs, sudo, my NAS account, etc.)
echo ""

# Getting sudo perms
echo $PASSWORD | sudo -S echo "Aquired sudo perms" # -S just yeets the password into sudo so i dont have to type it out again, and also dont need to remember to use sudo on the script
echo ""

# Checking if AMD GPU
if [[ $(sudo lshw -C display | grep vendor) =~ AMD ]]; then
    AMD_GPU=true
else
    AMD_GPU=false
fi

# Copy files
echo "Copying Files from Setup Folder"
mkdir ~/.ssh                                                                      #Create ssh config dir if not existing
cp -f ./ssh_config ~/.ssh/config                                                  #My ssh config with all my VMs that i internally need to ssh into
cp -f *.desktop ~/.local/share/applications/                                      #All the shortcuts i custom made and need sometimes
cp -f -r ./Tdarr ~                                                                #Raw Tdarr (transcoding Server and Node system) folder, without actual program, just the config and updater/installer
sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" ~/Tdarr/configs/Tdarr_Node_Config.json #Put hostname as Node name for Tdarr
cp -f -r ./autostart ~/.config/                                                   #Put my autostart things into the autostart (Startup Applications is the GUI for this)
cp -f ./update_pikaos.sh ~/update.sh                                              #My custom update script which also updates everything that cant use APT
cp -f ./start_rainbowminer.sh ~                                                   #Custom starter script to prevent lock or sleep
cp -f ./ICEBERG.qbtheme ~                                                         #My prefered QBittorrent Theme (Darkmode and nice and stuff)
mkdir ~/.config/qBittorrent                                                       #Create QBT config dir if not existing
cp -f ./qBittorrent.conf ~/.config/qBittorrent/                                   #config for QBT
cp -f ./watched_folders.json ~/.config/qBittorrent/                               #config for QBT
mkdir ~/.config/lutris                                                            #lutris config dir
mkdir ~/.config/lutris/runners                                                    #lutris config dir
cp -f ./lutris.conf ~/.config/lutris/                                             #lutris config
cp -f ./lutris_system.yml ~/.config/lutris/system.yml                             #lutris config for default install path
cp -f ./wine.yml ~/.config/lutris/runners/                                        #lutris config for standard virtual monitor size (since i use 1440p)
cp -f ./appimagelauncher.cfg ~/.config/                                           #config for the program that takes care of all AppImages ( https://github.com/TheAssassin/AppImageLauncher )
mkdir ~/.local                                                                    #create folde for user scripts and shortcuts
mkdir ~/.local/bin                                                                #create script dir
cp -f ./change-wallpaper ~/.local/bin/                                            #custom wallpaper switcher script
cp -f ./sync-wallpapers ~/.local/bin/                                             #custom wallpaper backup script
mkdir ~/.local/share                                                              #user dir for personal system managed things
cp -f -r ./backgrounds ~/.local/share                                             #my wallpapers
cp ./rainbowminer_config.txt ~                                                    #auto switching mining software for when i need some free heating

if [ $HOSTNAME = "Barbara" ]; then
    echo "We are on Barbara, mounting Games and owning it"
    sudo mkdir /mnt/Games
    echo "/dev/disk/by-uuid/e0076949-94d0-4135-92d9-9284ab29e1bb /mnt/Games ext4 nosuid,nodev,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab >/dev/null
    sudo systemctl daemon-reload
    sudo mount -a
    sudo chown aki -R /mnt/Games
fi
cat ./fstab | sudo tee -a /etc/fstab >/dev/null #attach fstab local to fstab system (my NAS shares)
cat ./.bashrc | tee -a ~/.bashrc >/dev/null     #attach bashrc local to user bashrc (apt is alias for nala)

mkdir /home/aki/Desktop/Code
mkdir /home/aki/Desktop/Code/discord_bots
echo ""

# Switch to home folder
cd ~

# Temp fixes
echo "Temp Fix for OpenJDK 20 not installing because of ca-certificates-java not being able to configure itself" #since it needs java, and java 20 needs certicates to install. Meaning they need each other, which cant work
sudo apt install openjdk-19-jre-headless openjdk-19-jre -y
sudo apt install ca-certificates-java -y
echo ""

# None temp fixes
if [ $HOSTNAME = "Barbara" ]; then
    echo "We are on Barbara, activating auto login"
    sudo sed -i "s/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/g" /etc/gdm3/custom.conf
    sudo sed -i "s/#  AutomaticLogin = user1/AutomaticLogin = aki/g" /etc/gdm3/custom.conf
    echo ""
fi

echo "Installing deps for OBS Virtual Cam"
sudo apt install v4l2loopback-dkms -y
echo ""

echo "Install packages for laptop audio"
sudo apt install alsa-base alsa-utils linux-sound-base libasound2 -y
echo ""

echo "There is a AutoStart .desktop file that fixes Keyboard Layout for XWayland Apps" #this is just for reminding myself
echo "(setxkbmap.desktop)"
echo ""

# Prepare
echo "Updating System"
sudo apt --fix-broken --fix-missing install -y
sudo dpkg --configure -a

sudo apt update
sudo apt upgrade -y
echo ""

echo "Installing Codecs"
sudo apt install -y pika-codecs-meta
echo ""

echo "Installing Drivers"
if $AMD_GPU; then
    sudo apt install pika-rocm-meta -y
    sudo apt install pika-amdgpu-core vulkan-amdgpu-pro vulkan-amdgpu-pro:i386 amf-amdgpu-pro amdvlk amdvlk:i386 ocl-icd-libopencl1-amdgpu-pro ocl-icd-libopencl1-amdgpu-pro:i386 opencl-legacy-amdgpu-pro-icd opencl-legacy-amdgpu-pro-icd:i386 -y #AMD GPU drivers (including legacy ones for RainbowMiner)
else
    python3 /usr/lib/linuxmint/mintdrivers/mintdrivers.py # 'mintdrivers' is python thing that just makes a subprocess, so i skipped that, so the script actually waits here until done (dont restart, just close mintdrivers)
fi
echo ""

# Installing APT and Flatpak Packages
echo "Installing Welcome App Packages"
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections #Accept ttf EULA automatically

sudo apt install pika-gameutils-meta pika-gameutils-meta-extra ttf-mscorefonts-installer blender obs-studio pika-libreoffice-meta fabiscafe-devices -y #install welcome apps
echo ""

echo "Installing Packages and Flatpaks"
sudo apt install unzip wget sshfs qbittorrent fonts-firacode deja-dup thunderbird handbrake-cli handbrake rpi-imager python-is-python3 python3-venv python3-pip wakeonlan gnome-clocks dconf-editor docker docker-compose -y # install packages i need
flatpak install spotify polymc net.davidotek.pupgui2 dev.geopjr.Collision io.github.realmazharhussain.GdmSettings -y                                                                                                         # install flatpaks i need
pip install hyfetch
echo ""

echo "Making sure all packages are working"
sudo apt --fix-broken install -y
sudo dpkg --configure -a
echo ""

# SSH Stuff
echo "Allowing auto accepting new ssh keys systemwide"
echo "    StrictHostKeyChecking accept-new" | sudo tee -a /etc/ssh/ssh_config >/dev/null #skip yes/no prompt when connecting to new ssh host
echo ""

echo "Activating SSH Server for SSH login"
sudo systemctl enable ssh
sudo systemctl start ssh
echo ""

echo "Generating SSH Key"
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa #options are preventing prompts
echo ""

echo "Copying SSH Key to Gutruhn (My NAS)"
sudo apt install sshpass -y #can put ssh passwords in automatically (stdin doesnt work because of openssh design choices)

sshpass -p "$PASSWORD" ssh-copy-id Aki@toasteruwu.com #this is my NAS, which i connect to via sshfs (SFTP with Fuse)
echo ""

echo "Setting up SSHFS"
# echo "user_allow_other" | sudo tee -a /etc/fuse.conf >/dev/null # This seems to break deja-dup

sudo mkdir /mnt/home
sudo mkdir /mnt/data
sudo mkdir /mnt/backups
sudo mkdir /mnt/web
sudo systemctl daemon-reload #not sure if after or before was needed, so just do both, cant hurt
sudo mount -a
sudo systemctl daemon-reload
echo ""

# Enabling VNC and RDP
gsettings set org.gnome.desktop.remote-desktop.vnc auth-method 'password'
gsettings set org.gnome.desktop.remote-desktop.vnc enable true
gsettings set org.gnome.desktop.remote-desktop.vnc view-only false

gsettings set org.gnome.desktop.remote-desktop.rdp enable true
gsettings set org.gnome.desktop.remote-desktop.rdp view-only false

# Wake on LAN
echo "Activating Wake on Lan"
sudo nmcli connection modify "Wired connection 1" 802-3-ethernet.wake-on-lan magic #super easy wake on lan (dont know why this is such a hidden gem), most people say "create like 2 systemd services by hand and do that and that and that and that" (This works if the name is correct)
echo ""

# Configuring GNOME and other DE stuff
echo "Installing Gnome Extensions"
sudo apt install gnome-menus gir1.2-gmenu-3.0 gir1.2-gtop-2.0 -y #needed for some Appindicators

export PATH="$HOME/.local/bin:$PATH" #update PATH, needed to have pip in path for some reason

pip install gnome-extensions-cli #python and pip are aliases for python3 and pip3 thanks to 'python-is-python3' (installed earlier)

for extension in $( #disable everything
    gnome-extensions list
); do
    gnome-extensions-cli disable $extension
done

EXTENSIONS="615 3628 1401 4839 1160 2087 841 1319 750 19"
wget -N -q "https://raw.githubusercontent.com/ToasterUwU/install-gnome-extensions/master/install-gnome-extensions.sh" -O ./install-gnome-extensions.sh
chmod +x install-gnome-extensions.sh
./install-gnome-extensions.sh $EXTENSIONS --enable
rm -f ./install-gnome-extensions.sh
echo ""

echo "Power Settings" # Dont sleep when plugged into Power, sleep after 20 minutes if on battery, turn monitor of after 15 minutes, show battery percentage, shut down when pressing power button
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1200
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.interface show-battery-percentage true
echo ""

echo "Wallpaper Switcher" #make soft link to desktop for ~/.local/share/backgrounds (Gnome wallpaper location)
ln -s /home/aki/.local/share/backgrounds /home/aki/Desktop
mv /home/aki/Desktop/backgrounds /home/aki/Desktop/Wallpapers #rename soft link to Wallpapers

chmod +x /home/aki/.local/bin/change-wallpaper
chmod +x /home/aki/.local/bin/sync-wallpapers

crontab -l >mycron                                                                                                                      #write out current crontab
echo "*/15 * * * * env DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /home/aki/.local/bin/change-wallpaper" >>mycron #echo new cron into cron file (change wallpaper every 15th minute 0/15/30/45)
crontab mycron                                                                                                                          #install new cron file
rm mycron                                                                                                                               #remove temp file

change-wallpaper #change wallpaper for the first time
echo ""

echo "Enabling Dark Mode with Pink Accent Colors" #this is the what the "style your desktop" thing in the welcome app does
sudo apt install pika-gnome-layouts -y            #needed for nautilus color switching

/usr/lib/pika/gnome-layouts/dconf-accent.sh Purple
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
sudo /usr/lib/pika/gnome-layouts/papirus-folders -u -C magenta #nautilus folder color
echo ""

echo "Setting Gnome Terminal default size" #make it fullscreen when opening (240, 100 should work, if not just put it higher)
profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
profile=${profile:1:-1} # remove leading and trailing single quotes
gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" default-size-columns 240
gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" default-size-rows 100
echo ""

echo "Setting Nautilus Preferences"
gsettings set org.gnome.nautilus.preferences show-delete-permanently true
gsettings set org.gtk.Settings.FileChooser show-hidden true
echo ""

echo "Setting up Deja Dup"                                                                  #backup to NAS
gsettings set org.gnome.DejaDup backend 'local'                                             #SSHFS is technically local
gsettings set org.gnome.DejaDup delete-after 90                                             #keep 3 months
gsettings set org.gnome.DejaDup exclude-list "['/home/aki/RainbowMiner', '/media', '/mnt']" #ignore crypto miner, NAS and non boot drives
gsettings set org.gnome.DejaDup include-list "['$HOME']"                                    #backup all my home things
mkdir "/mnt/backups/$HOSTNAME"                                                              #create folder for backups if needed
gsettings set org.gnome.DejaDup.Local folder "/mnt/backups/$HOSTNAME"                       #set folder for backups
gsettings set org.gnome.DejaDup periodic true                                               #auto backup
gsettings set org.gnome.DejaDup periodic-period 1                                           #auto backup once a day (incremental, so no big deal)
echo ""

echo "General Gnome Settings"
gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true                 #activate numlock by default (so numpad makes numbers)
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close" #activate minimize, maximaze and close button instead of just close button
gsettings set org.gnome.desktop.interface clock-format '24h'                            #24 hour time, since im not from the US
gsettings set org.gnome.desktop.interface enable-hot-corners false                      #hate hot corner, annoying and thats it
#taskbar pinned apps
gsettings set org.gnome.shell favorite-apps "['org.gnome.Settings.desktop', 'custom-update.desktop', 'org.gnome.Terminal.desktop', 'mintinstall.desktop', 'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'brave-browser.desktop', 'com.spotify.Client.desktop', 'discord.desktop', 'steam.desktop', 'net.lutris.Lutris.desktop', 'code.desktop']"
echo ""

echo "Dash to Panel Settings"
#dont show applications button, since i dont care
gsettings set org.gnome.shell.extensions.dash-to-panel panel-element-positions '{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"2":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'
echo ""

echo "Arcmenu Settings"
gsettings set org.gnome.shell.extensions.arcmenu pinned-app-list "['Change Wallpaper', '', 'change-wallpaper.desktop']" #only default pinned app is my custom change wallpaper thing
gsettings set org.gnome.shell.extensions.arcmenu custom-menu-button-icon '/usr/share/pixmaps/pika-logo.svg'             #little birb as button, not Nobora logo
gsettings set org.gnome.shell.extensions.arcmenu menu-button-appearance 'Icon'                                          #use icon
gsettings set org.gnome.shell.extensions.arcmenu menu-button-icon 'Custom_Icon'                                         #use custom birb
gsettings set org.gnome.shell.extensions.arcmenu custom-menu-button-icon-size 35.0                                      #make logo big enough to see
echo ""

echo "OpenWeather Settings"
dconf write /org/gnome/shell/extensions/openweather/city "'52.4205588,10.7861682>Wolfsburg, Niedersachsen, Deutschland>0'" #Show weather for where i live, not toronto
echo ""

echo "Freon Settings"
dconf write /org/gnome/shell/extensions/freon/hot-sensors "['Tctl', 'junction']" #show CPU and GPU temps, if not correct it will just show little caution triangles
echo ""

# Git config
echo "Git Config"
git config --global user.name ToasterUwU
git config --global user.email aki@toasteruwu.com
echo ""

# Installing programs that need extra repos, dont use apt, etc
echo "Install Github CLI"
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
echo ""

echo "Install Brave" #my browser
sudo apt install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser -y

xdg-settings set default-web-browser brave-browser.desktop
echo ""

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

echo "Installing VSCode"
sudo apt install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y

wget -qO- https://raw.githubusercontent.com/harry-cpp/code-nautilus/master/install.sh | bash #Create 'Open in Code' option in Nautilus, like on Windows
echo ""

echo "Installing Balena Etcher"
curl -1sLf 'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' | distro=ubuntu version=22.04 codename=jammy sudo -E bash # have to force version since it doesnt know PikaOS
sudo apt update
sudo apt install balena-etcher-electron -y
echo ""
cd ~

echo "Installing RainbowMiner"
sudo apt install rocm-smi -y #needed for Rainbowminer to see AMD GPU

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
sudo chmod -R 0777 RainbowMiner/ #litle fix since some thing dont really set the right permissions
echo ""

echo "Installing Tdarr Node"
cd Tdarr

wget "https://f000.backblazeb2.com/file/tdarrs/versions/2.00.15/linux_x64/Tdarr_Updater.zip" -O ./updater.zip
unzip -o ./updater.zip
rm -f ./updater.zip

./Tdarr_Updater #install Tdarr Node (transcoder which works on job from Tdarr Server)
echo ""
cd ~

echo "Install Rust Lang" #not one liner so i can tell it to not prompt me
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o "rustup-init.sh"
bash rustup-init.sh -y
rm rustup-init.sh
echo ""

echo "Installing ProtonVPN repo and app in the ass backwards way"
wget "https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb" -O ~/protonvpn-repo.deb
sudo apt install ~/protonvpn-repo.deb -y
rm -f ~/protonvpn-repo.deb

sudo apt update
sudo apt install gir1.2-appindicator3-0.1 -y # Deps for AppIndicator Support of ProtonVPN

sudo apt install protonvpn -y
echo ""

echo "Install ProtonMail Bridge"
wget "https://proton.me/download/bridge/protonmail-bridge_3.0.19-1_amd64.deb" -O ~/protonmail-bridge.deb
sudo apt install ~/protonmail-bridge.deb -y
rm -f ~/protonmail-bridge.deb
echo ""

echo "Install Discord"
wget "https://discord.com/api/download?platform=linux&format=deb" -O ~/discord.deb
sudo apt install ~/discord.deb -y
rm -f ~/discord.deb
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
cd ~/Desktop
wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -O bitwarden.AppImage

xdg-open bitwarden.AppImage #open with AppImage launcher (prompt to integrate/install and run. No idea how to do this silently...)
echo ""
cd ~

echo "Installing Ledger Live"
cd ~/Desktop
wget "https://download.live.ledger.com/latest/linux" -O ledger_live.AppImage
wget -q -O - "https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh" | sudo bash

xdg-open ledger_live.AppImage #open with AppImage Launcher again
echo ""
cd ~

echo "Running Steam for first time setup. Please close when done."
steam #just want to download the runtime before restarting
echo ""

echo "Same for Lutris"
lutris #runtime download again
echo ""

echo "Install Proton-GE, close when done"
flatpak run net.davidotek.pupgui2 #install proton-GE manually, since no idea how to do it automatically without much more work than its worth
echo ""

echo "First Backup with Deja-Dup"
deja-dup #Deja dup needs to be started and clicked trough the already configured options, so that it works. (Can click the 'Resume Later' button when it starts backup)
echo ""

# Enable screen lock again
echo "Reenabling Screenlock"
gsettings set org.gnome.desktop.screensaver idle-activation-enabled true
gsettings set org.gnome.desktop.screensaver lock-enabled true
echo ""

# Reboot to make everything work smoothly
sudo reboot
