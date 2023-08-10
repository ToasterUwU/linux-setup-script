echo "Installing deps for OBS Virtual Cam"
sudo apt install v4l2loopback-dkms -y
echo ""

echo "Install libfuse to be able to use AppImages"
sudo apt install libfuse2
echo ""