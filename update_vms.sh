#!/bin/bash

HOSTS_TO_UPDATE="discord-bots
internet-vm
mongo-db
smart-home
surreal-db
tdarr-server
tor-node
xen-orchestra"

read -sp "Password please: " PASSWORD

echo $PASSWORD | sudo -S echo "Aquired sudo perms"
echo ""

for host in $HOSTS_TO_UPDATE; do
    echo $host
    sshpass -p $PASSWORD ssh $host "echo $PASSWORD | sudo -S bash update.sh"
    echo ""
    echo ""
done

echo "Started updates everywhere"
sleep 5
