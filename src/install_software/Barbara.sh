echo "Installing Welcome App Packages"
sudo apt install -y pika-gameutils-meta #install welcome apps
echo ""

echo "Installing Packages and Flatpaks"
flatpak install -y org.prismlauncher.PrismLauncher com.vysp3r.ProtonPlus
pip install protonup
echo ""
