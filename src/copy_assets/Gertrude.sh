sudo rsync -rltov $CWD/assets/Gertrude/ALL/ /

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg
sudo chown aki ~/.ssh/id_rsa
sudo chown aki ~/.ssh/id_rsa.pub
sudo chmod 600 ~/.ssh/id_rsa
sudo chmod 600 ~/.ssh/id_rsa.pub
ssh-add
