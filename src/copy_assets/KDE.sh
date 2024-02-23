#!/bin/bash

copy_assets ALL/KDE

sed -i "s/PLACEHOLDERHOSTNAME/$HOSTNAME/g" /home/aki/.config/kuprc
