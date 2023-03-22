#!/bin/bash

# Get Password
read -sp "Password please: " PASSWORD
echo ""

# Getting sudo perms
echo $PASSWORD | sudo -S echo "Aquired sudo perms"
echo ""

rustup update

flatpak update -y

cd /home/aki/Tdarr
./Tdarr_Updater

cd /home/aki/RainbowMiner
./updater.sh

sudo nala upgrade -y

read -p "Press enter to continue"
