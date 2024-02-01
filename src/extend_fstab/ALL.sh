#!/bin/bash

echo "Install SSHFS"
sudo apt install sshfs -y
echo ""

echo "Adding SSHFS Entries"
sudo mkdir /mnt/home
sudo mkdir /mnt/data
sudo mkdir /mnt/backups
sudo mkdir /mnt/web

SSHFS_ENTRIES="
# SSHFS connections to Gutruhn

Aki@toasteruwu.com:/home /mnt/home fuse.sshfs x-gvfs-show,delay_connect,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1001,gid=1001,exec 0 0
Aki@toasteruwu.com:/data /mnt/data fuse.sshfs x-gvfs-show,delay_connect,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1001,gid=1001,exec 0 0
Aki@toasteruwu.com:/backups /mnt/backups fuse.sshfs x-gvfs-show,delay_connect,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1001,gid=1001,exec 0 0
Aki@toasteruwu.com:/web /mnt/web fuse.sshfs x-gvfs-show,delay_connect,reconnect,ServerAliveInterval=10,ServerAliveCountMax=2,x-systemd.automount,x-systemd.requires=network-online.target,_netdev,user,idmap=user,transform_symlinks,identityfile=/home/aki/.ssh/id_rsa,allow_other,default_permissions,uid=1001,gid=1001,exec 0 0
# Options explained: show in file explorer, wait a bit for connecting so that DNS works, reconnect when connection lost, its lost if you cant get it for the third time and you check every 10 seconds, you use systemd automount since it works better, you wait for lan connectivity, this is meant to be a user thing, follow symlinks, use ssh key, allow others to access (meaning the user and not just root), user is 1001/1001, allow running programs from it
"

echo "$SSHFS_ENTRIES" | sudo tee -a /etc/fstab >/dev/null # add sshfs entries (my NAS shares)
echo ""

echo "Mounting SSHFS Entries"
sudo mount -a
mkdir "/mnt/backups/$HOSTNAME/"
echo ""
