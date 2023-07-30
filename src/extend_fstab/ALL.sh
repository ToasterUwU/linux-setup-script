sudo mkdir /mnt/home
sudo mkdir /mnt/data
sudo mkdir /mnt/backups
sudo mkdir /mnt/web

echo "Copying SSH Key to Gutruhn (My NAS)"
sudo apt install sshpass -y #can put ssh passwords in automatically (stdin doesnt work because of openssh design choices)

sshpass -p "$PASSWORD" ssh-copy-id Aki@toasteruwu.com #this is my NAS, which i connect to via sshfs (SFTP with Fuse)
echo ""

echo "Install SSHFS"
sudo apt install sshfs -y
echo ""

echo "Adding SSHFS Entries"
SSHFS_ENTRIES="
# SSHFS connections to Gutruhn

Aki@toasteruwu.com:/home /mnt/home fuse.sshfs x-gvfs-show,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1000,gid=1000,exec 0 0
Aki@toasteruwu.com:/data /mnt/data fuse.sshfs x-gvfs-show,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1000,gid=1000,exec 0 0
Aki@toasteruwu.com:/backups /mnt/backups fuse.sshfs x-gvfs-show,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1000,gid=1000,exec 0 0
Aki@toasteruwu.com:/web /mnt/web fuse.sshfs x-gvfs-show,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1000,gid=1000,exec 0 0
# Options explained: reconnect when connection lost, its lost if you cant get it for the third time and you check every 10 seconds, you use systemd automount since it works better, you wait for lan connectivity, this is meant to be a user thing, follow symlinks, use ssh key, allow others to access (meaning the user and not just root), user is 1000/1000, allow running programs from it
"

echo $SSHFS_ENTRIES | sudo tee -a /etc/fstab >/dev/null # add sshfs entries (my NAS shares)
echo ""

echo "Mounting SSHFS Entries"
sudo mount -a
echo ""