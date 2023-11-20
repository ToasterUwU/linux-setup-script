copy_assets ALL/ALL

decrypt_file ~/microsoft_rewards_bot_accounts.json.gpg

decrypt_file ~/.smb.gpg
sudo chmod 0600 /home/aki/.smb

sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" ~/Tdarr/configs/Tdarr_Node_Config.json

mkdir ~/Desktop/Code

sudo chown aki:aki ~/.var/app/com.ultimaker.cura/config/cura/* -R
sudo chmod 0700 ~/.var/app/com.ultimaker.cura/config/cura/* -R