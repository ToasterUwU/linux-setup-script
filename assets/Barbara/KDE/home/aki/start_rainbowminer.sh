echo "Disabling Screenlock until done"
cleanup() {
    /bin/kill "$INHIBIT_PID"
}

trap cleanup EXIT

inhibitcmd="kde-inhibit --screenSaver --power sleep infinity"
$inhibitcmd >/dev/null 2>&1 &

INHIBIT_PID=$!
echo ""

# Get Password
read -sp "Password please: " PASSWORD # Get password that i use for all internal things and for my password managers (SSH to all my VMs, sudo, my NAS account, etc.)
echo ""

# Getting sudo perms
echo $PASSWORD | sudo -S echo "Thanks, checking password" >/dev/null 2>&1 # -S just yeets the password into sudo so i dont have to type it out again, and also dont need to remember to use sudo on the script
echo ""

sudo -n true 2>/dev/null
if ! [ $? -eq 0 ]; then
    echo "Password Wrong"
    read -p "Press enter to continue"
    exit 0
fi

cd /home/aki/RainbowMiner
/home/aki/RainbowMiner/updater.sh
sudo /home/aki/RainbowMiner/install.sh
/home/aki/RainbowMiner/start.sh
echo ""
