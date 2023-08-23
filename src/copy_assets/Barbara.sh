sudo rsync -rltv $CWD/assets/Barbara/ALL/ /

sed -i "s/PLACEHOLDERWORKER/$HOSTNAME/g" ./rainbowminer_config.txt   #set miner name as hostname
sed -i "s/PLACEHOLDERPASSWORD/$PASSWORD/g" ./rainbowminer_config.txt #set password

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg
sudo chown aki ~/.ssh/id_rsa
sudo chown aki ~/.ssh/id_rsa.pub
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub
ssh-add