#!/bin/bash

echo "Gertrude KDE Config"
cd ~/Gertrude.knsv.d && zip -r ../Gertrude.knsv ./* && cd ~ || exit
konsave -i Gertrude.knsv && konsave -a Gertrude
echo ""
