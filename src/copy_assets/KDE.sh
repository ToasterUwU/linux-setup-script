copy_assets ALL/KDE

sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" /home/aki/.config/kuprc

decrypt_file ~/start_microsoft_rewards_bot.sh.gpg

sudo plasmapkg2 -i ~/applet-wunderground-pws.plasmoid && rm -f ~/applet-wunderground-pws.plasmoid