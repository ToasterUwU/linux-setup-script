#!/bin/bash

sudo nmcli connection modify "Wired connection 1" 802-3-ethernet.wake-on-lan magic #super easy wake on lan (dont know why this is such a hidden gem), most people say "create like 2 systemd services by hand and do that and that and that and that" (This works if the name is correct)
