#!/bin/bash

echo "Git Config"
git config --global user.name ToasterUwU
git config --global user.email aki@toasteruwu.com
git config --global pull.rebase false
echo ""

echo "Install Python Packages"
sudo apt install -y python3-venv
echo ""

echo "Installing NodeJS"
sudo apt install -y npm nodejs
echo ""

echo "Installing VSCode"
sudo apt update
sudo apt install code -y
echo ""

echo "Install other Packages needed"
sudo apt install -y fonts-firacode
echo ""
