echo "We are on Barbara, mounting Games and owning it"
echo "/dev/disk/by-uuid/e0076949-94d0-4135-92d9-9284ab29e1bb /mnt/Games ext4 nosuid,nodev,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab >/dev/null
sudo systemctl daemon-reload

sudo mount /dev/disk/by-uuid/e0076949-94d0-4135-92d9-9284ab29e1bb /mnt/Games/

sudo chown aki -R /mnt/Games
echo ""
