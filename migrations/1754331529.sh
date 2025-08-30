echo "Update Waybar for new OSVMarchi menu"

if ! grep -q "" ~/.config/waybar/config.jsonc; then
  osvmarchi-refresh-waybar
fi
