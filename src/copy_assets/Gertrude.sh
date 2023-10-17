copy_assets Gertrude/ALL

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg
sudo chown aki ~/.ssh/ -R
sudo chmod 600 ~/.ssh/ -R
ssh-add
