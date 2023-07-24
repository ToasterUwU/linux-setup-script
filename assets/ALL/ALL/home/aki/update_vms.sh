#!/bin/bash

HOSTS_TO_UPDATE="discord-bots
mongo-db
surreal-db
internet-vm
smart-home
tdarr-server
tor-node
xen-orchestra"

# Get Password
read -sp "Password please: " PASSWORD # Get password that i use for all internal things and for my password managers (SSH to all my VMs, sudo, my NAS account, etc.)
echo ""

# Getting sudo perms
echo $PASSWORD | sudo -S echo "Thanks, checking password" >/dev/null 2>&1 # -S just yeets the password into sudo so i dont have to type it out again, and also dont need to remember to use sudo on the script
echo ""

sudo -n true 2>/dev/null
if ! [ $? -eq 0 ]; then
    echo "Password Wrong"
    read -p "Press enter to continue"
    exit 0
fi

for host in $HOSTS_TO_UPDATE; do
    echo -e "\033[1m\033[32m$host\033[0m"
    sshpass -p $PASSWORD ssh $host "echo $PASSWORD | sudo -S bash update.sh"
    echo -e "\033[1m\033[32mDone\033[0m"
    echo ""
done

echo "Updated everything, VMs are rebooting"
read -p "Press enter to continue"
