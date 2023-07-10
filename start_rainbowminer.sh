echo "Disabling Screenlock until done"
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
echo ""

# Get Password
read -sp "Password please: " PASSWORD # Get password that i use for all internal things and for my password managers (SSH to all my VMs, sudo, my NAS account, etc.)
echo ""

# Getting sudo perms
echo $PASSWORD | sudo -S echo "Aquired sudo perms" # -S just yeets the password into sudo so i dont have to type it out again, and also dont need to remember to use sudo on the script
echo ""

cd /home/aki/RainbowMiner
/home/aki/RainbowMiner/updater.sh
sudo /home/aki/RainbowMiner/install.sh
/home/aki/RainbowMiner/start.sh
echo ""

echo "Reenabling Screenlock"
gsettings set org.gnome.desktop.session idle-delay 900
gsettings reset org.gnome.desktop.screensaver lock-enabled
echo ""
