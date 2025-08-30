echo "Add new OSVMarchi Menu icon to Waybar"

mkdir -p ~/.local/share/fonts
cp ~/.local/share/osvmarchi/config/osvmarchi.ttf ~/.local/share/fonts/
fc-cache

echo
gum confirm "Replace current Waybar config (backup will be made)?" && osvmarchi-refresh-waybar
