echo "Update Waybar config to fix path issue with update-available icon click"

if grep -q "alacritty --class OSVMarchi --title OSVMarchi -e osvmarchi-update" ~/.config/waybar/config.jsonc; then
  sed -i 's|\("on-click": "alacritty --class OSVMarchi --title OSVMarchi -e \)osvmarchi-update"|\1osvmarchi-update"|' ~/.config/waybar/config.jsonc
  osvmarchi-restart-waybar
fi
