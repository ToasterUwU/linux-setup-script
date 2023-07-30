echo "We are on Barbara, activating auto login"
sudo sed -i "s/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/g" /etc/gdm3/custom.conf
sudo sed -i "s/#  AutomaticLogin = user1/AutomaticLogin = aki/g" /etc/gdm3/custom.conf
echo ""
