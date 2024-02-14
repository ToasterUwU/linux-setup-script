#!/bin/bash

copy_assets Barbara/ALL

sed -i "s/PLACEHOLDERWORKER/$HOSTNAME/g" ./rainbowminer_config.txt   #set miner name as hostname
sed -i "s/PLACEHOLDERPASSWORD/$PASSWORD/g" ./rainbowminer_config.txt #set password

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg
sudo chown aki:aki ~/.ssh/ -R
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/known_hosts
chmod 600 ~/.ssh/config
ssh-add

sudo chown aki:aki ~/.config/unity3d/Misfits Attic/Duskers/* -R
sudo chmod 700 ~/.config/unity3d/Misfits Attic/Duskers/* -R
