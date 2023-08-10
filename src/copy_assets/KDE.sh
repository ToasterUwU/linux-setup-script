sudo rsync -av $CWD/assets/ALL/KDE/ /

mkdir "/mnt/backups/$HOSTNAME/"
sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" /home/aki/.config/kuprc
