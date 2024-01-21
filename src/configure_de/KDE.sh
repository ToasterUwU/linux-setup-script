echo "Setting Numlock to be on by default"
kwriteconfig5 --file ~/.config/kcminputrc --group Keyboard --key NumLock "0"
echo ""

echo "Setting Folder color of Papirus"
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -u -C magenta
echo ""
