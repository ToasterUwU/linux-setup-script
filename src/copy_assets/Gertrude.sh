sudo rsync -rltv $CWD/assets/Gertrude/ALL/ /

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg
ssh-add
