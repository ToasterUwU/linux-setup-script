sudo rsync -av assets/Barbara/ALL/ /

sed -i "s/PLACEHOLDERWORKER/$HOSTNAME/g" ./rainbowminer_config.txt   #set miner name as hostname
sed -i "s/PLACEHOLDERPASSWORD/$PASSWORD/g" ./rainbowminer_config.txt #set password

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg