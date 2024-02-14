#!/bin/bash

copy_assets Gertrude/ALL

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
