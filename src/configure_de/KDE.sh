echo "Setting Numlock to be on by default"
NUMLOCK_SETTING="
[Keyboard]
NumLock=0
"
echo "$NUMLOCK_SETTING" | sudo tee -a ~/.config/kcminputrc >/dev/null # add sshfs entries (my NAS shares)
echo ""