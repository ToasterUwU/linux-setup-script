echo "Installing Welcome App Packages"
sudo apt install -y pika-gameutils-meta #install welcome apps
echo ""

echo "Installing Packages and Flatpaks"
sudo apt install openrgb -y
flatpak install -y org.prismlauncher.PrismLauncher com.vysp3r.ProtonPlus
pip install protonup --break-system-packages
echo ""
