echo "Update Waybar CSS to dim unused workspaces"

if ! grep -q "#workspaces button\.empty" ~/.config/waybar/style.css; then
  osvmarchi-refresh-config waybar/style.css
  osvmarchi-restart-waybar
fi
