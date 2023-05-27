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
    nohup sshpass -p $PASSWORD ssh $host "echo $PASSWORD | sudo -S bash update.sh" >/dev/null 2>&1 &
done

echo "Started updates everywhere"
sleep 5
