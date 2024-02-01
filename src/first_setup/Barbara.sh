#!/bin/bash

echo "Running Steam for first time setup. Please close when done."
timeout 90s steam #just want to download the runtime before restarting
echo ""

echo "Same for Lutris"
timeout 90s lutris #runtime download again
echo ""

echo "Installing Proton-GE"
protonup -d "~/.steam/root/compatibilitytools.d/"
protonup -y
echo ""
