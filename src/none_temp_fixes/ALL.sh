echo "Installing deps for OBS Virtual Cam"
sudo apt install v4l2loopback-dkms -y
echo ""

echo "Install libfuse to be able to use AppImages"
sudo apt install libfuse2 -y
echo ""

echo "Remove that annoying Update Manager"
sudo rm -f /usr/bin/update-manager
echo ""
