echo "Disabling Mouse Acceleration"
ACCELERATION_SETTING="
[Libinput][1133][49970][Logitech Gaming Mouse G502]
PointerAccelerationProfile=1
"
echo "$ACCELERATION_SETTING" | sudo tee -a ~/.config/kcminputrc >/dev/null
echo ""