echo "Installing deps for OBS Virtual Cam"
sudo apt install v4l2loopback-dkms -y
echo ""

echo "Install libfuse to be able to use AppImages"
sudo apt install libfuse2 -y
echo ""

echo "Install Theme that i like manually so it doesnt get removed"
sudo apt install orchis-theme-gtk -y
echo ""