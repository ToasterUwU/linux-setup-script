#!/bin/bash

copy_assets Gertrude/ALL

decrypt_file ~/.ssh/id_rsa.gpg
decrypt_file ~/.ssh/id_rsa.pub.gpg
sudo chown aki:aki ~/.ssh/ -R
sudo chmod 0600 ~/.ssh/ -R
ssh-add
