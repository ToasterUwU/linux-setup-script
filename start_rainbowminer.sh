gsettings set org.gnome.desktop.screensaver idle-activation-enabled false
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

cd /home/aki/RainbowMiner
/home/aki/RainbowMiner/start.sh

gsettings set org.gnome.desktop.screensaver idle-activation-enabled true
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.settings-daemon.plugins.power idle-dim true
