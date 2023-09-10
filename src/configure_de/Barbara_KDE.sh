echo "Disabling Mouse Acceleration"
NUMLOCK_SETTING="
[Libinput][1133][49970][Logitech Gaming Mouse G502]
PointerAccelerationProfile=1
"
echo "$NUMLOCK_SETTING" | sudo tee -a ~/.config/kcminputrc >/dev/null
echo ""