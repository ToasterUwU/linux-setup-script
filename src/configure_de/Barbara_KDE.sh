#!/bin/bash

echo "Barbara KDE Config"
cd ~/Barbara.knsv.d && zip -r ../Barbara.knsv ./* && cd ~ || exit
konsave -i Barbara.knsv && konsave -a Barbara
echo ""
