#!/bin/bash

copy_assets ALL/KDE

sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" /home/aki/.config/kuprc

decrypt_file ~/start_microsoft_rewards_bot.sh.gpg