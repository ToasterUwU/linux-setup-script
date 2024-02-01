#!/bin/bash

copy_assets Barbara/ALL

sed -i "s/PLACEHOLDERWORKER/$HOSTNAME/g" ./rainbowminer_config.txt   #set miner name as hostname
sed -i "s/PLACEHOLDERPASSWORD/$PASSWORD/g" ./rainbowminer_config.txt #set password

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg
sudo chown aki:aki ~/.ssh/ -R
sudo chmod 0600 ~/.ssh/ -R
ssh-add

sudo chown aki:aki ~/.config/unity3d/Misfits Attic/Duskers/* -R
sudo chmod 0700 ~/.config/unity3d/Misfits Attic/Duskers/* -R
