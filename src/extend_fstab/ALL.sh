echo "Adding SMB Entries"
sudo mkdir /mnt/home
sudo mkdir /mnt/data
sudo mkdir /mnt/backups
sudo mkdir /mnt/web

SMB_ENTRIES="
# SMB connections to Gutruhn

//Aki@192.168.178.3/home /mnt/home cifs credentials=/home/aki/.smb,iocharset=utf8,uid=1000,gid=1000,dir_mode=0755,file_mode=0644 0 0
//Aki@192.168.178.3/data /mnt/data cifs credentials=/home/aki/.smb,iocharset=utf8,uid=1000,gid=1000,dir_mode=0755,file_mode=0644 0 0
//Aki@192.168.178.3/backups /mnt/backups cifs credentials=/home/aki/.smb,iocharset=utf8,uid=1000,gid=1000,dir_mode=0755,file_mode=0644 0 0
//Aki@192.168.178.3/web /mnt/web cifs credentials=/home/aki/.smb,iocharset=utf8,uid=1000,gid=1000,dir_mode=0755,file_mode=0644 0 0
"

echo "$SMB_ENTRIES" | sudo tee -a /etc/fstab >/dev/null # add sshfs entries (my NAS shares)
echo ""

echo "Mounting SMB Entries"
sudo mount -a
mkdir "/mnt/backups/$HOSTNAME/"
echo ""
