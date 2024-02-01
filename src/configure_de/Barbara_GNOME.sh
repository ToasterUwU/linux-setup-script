#!/bin/bash

echo "Freon Settings"
dconf write /org/gnome/shell/extensions/freon/hot-sensors "['Tctl', 'junction']" #show CPU and GPU temps, if not correct it will just show little caution triangles
echo ""