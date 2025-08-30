echo "Allow updating of timezone by right-clicking on the clock (or running osvmarchi-cmd-tzupdate)"
if ! command -v tzupdate &>/dev/null; then
  bash ~/.local/share/osvmarchi/install/config/timezones.sh
  osvmarchi-refresh-waybar
fi
