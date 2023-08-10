echo "Installing Gnome Extensions"
sudo apt install gnome-menus gir1.2-gmenu-3.0 gir1.2-gtop-2.0 -y #needed for some Appindicators

pip install gnome-extensions-cli --break-system-packages #python and pip are aliases for python3 and pip3 thanks to 'python-is-python3' (installed earlier)

IGNORE_EXTENSIONS="pika-darkmode@pika.com"
for extension in $( #disable everything
    gnome-extensions list
); do
    if [[ $IGNORE_EXTENSIONS != *"$extension"* ]]; then
        gnome-extensions-cli disable $extension
    fi
done

EXTENSIONS="615 3628 4839 1160 2087 841 1319 750 19"
wget -N -q "https://raw.githubusercontent.com/ToasterUwU/install-gnome-extensions/master/install-gnome-extensions.sh" -O ./install-gnome-extensions.sh
bash ./install-gnome-extensions.sh $EXTENSIONS --enable
rm ./install-gnome-extensions.sh
echo ""

echo "Power Settings" # Dont sleep when plugged into Power, sleep after 20 minutes if on battery, turn monitor of after 15 minutes, show battery percentage, shut down when pressing power button
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1200
gsettings set org.gnome.desktop.interface show-battery-percentage true
echo ""

echo "Wallpaper Switcher" #make soft link to ~/.local/share/backgrounds (Gnome wallpaper location)
rm -rf /home/aki/.local/share/backgrounds
ln -s /home/aki/Desktop/Wallpapers /home/aki/.local/share/
mv /home/aki/.local/share/Wallpapers /home/aki/.local/share/backgrounds #rename soft link to backgrounds

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
gsettings set org.gnome.shell favorite-apps "['org.gnome.Settings.desktop', 'custom-update.desktop', 'org.gnome.Terminal.desktop', 'mintinstall.desktop', 'thunderbird.desktop', 'org.gnome.Nautilus.desktop', 'brave-browser.desktop', 'com.spotify.Client.desktop', 'armcord.desktop', 'steam.desktop', 'net.lutris.Lutris.desktop', 'code.desktop']"
echo ""

echo "Dash to Panel Settings"
#dont show applications button, since i dont care
dconf write /org/gnome/shell/extensions/dash-to-panel/panel-element-positions "'{\"0\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}],\"1\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}],\"2\":[{\"element\":\"showAppsButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"activitiesButton\",\"visible\":false,\"position\":\"stackedTL\"},{\"element\":\"leftBox\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"taskbar\",\"visible\":true,\"position\":\"stackedTL\"},{\"element\":\"centerBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"rightBox\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"dateMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"systemMenu\",\"visible\":true,\"position\":\"stackedBR\"},{\"element\":\"desktopButton\",\"visible\":true,\"position\":\"stackedBR\"}]}'"
echo ""

echo "Arcmenu Settings"
dconf write /org/gnome/shell/extensions/arcmenu/pinned-app-list "['Change Wallpaper', '', 'change-wallpaper.desktop']" #only default pinned app is my custom change wallpaper thing
dconf write /org/gnome/shell/extensions/arcmenu/custom-menu-button-icon "'/usr/share/pixmaps/pika-logo.svg'"           #little birb as button, not Nobora logo
dconf write /org/gnome/shell/extensions/arcmenu/menu-button-appearance "'Icon'"                                        #use icon
dconf write /org/gnome/shell/extensions/arcmenu/menu-button-icon "'Custom_Icon'"                                       #use custom birb
dconf write /org/gnome/shell/extensions/arcmenu/custom-menu-button-icon-size 35.0                                      #make logo big enough to see
dconf write /org/gnome/shell/extensions/arcmenu/button-padding 5
echo ""

echo "OpenWeather Settings"
dconf write /org/gnome/shell/extensions/openweather/city "'52.4205588,10.7861682>Wolfsburg, Niedersachsen, Deutschland>0'" #Show weather for where i live, not toronto
echo ""

echo "Freon Settings"
dconf write /org/gnome/shell/extensions/freon/hot-sensors "['Tctl', 'junction']" #show CPU and GPU temps, if not correct it will just show little caution triangles
echo ""
