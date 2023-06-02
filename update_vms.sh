#!/bin/bash

HOSTS_TO_UPDATE="discord-bots
mongo-db
surreal-db
internet-vm
smart-home
tdarr-server
tor-node
xen-orchestra"

read -sp "Password please: " PASSWORD

echo $PASSWORD | sudo -S echo "Aquired sudo perms"
echo ""

for host in $HOSTS_TO_UPDATE; do
    echo -e "\033[1m\033[32m$host\033[0m"
    sshpass -p $PASSWORD ssh $host "echo $PASSWORD | sudo -S bash update.sh"
    echo -e "\033[1m\033[32mDone\033[0m"
    echo ""
done

echo "Updated everything, VMs are rebooting"
read -p "Press enter to continue"
