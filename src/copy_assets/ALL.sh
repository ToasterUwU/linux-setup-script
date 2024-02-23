#!/bin/bash

copy_assets ALL/ALL

sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" ~/Tdarr/configs/Tdarr_Node_Config.json

mkdir ~/Desktop/Code