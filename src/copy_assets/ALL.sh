copy_assets ALL/ALL

decrypt_file ~/microsoft_rewards_bot_accounts.json.gpg

sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" ~/Tdarr/configs/Tdarr_Node_Config.json