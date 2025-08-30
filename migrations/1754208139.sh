echo "Ensure screensaver doesn't start while the computer is locked"

if ! grep -q "pidof hyprlock || osvmarchi-launch-screensaver" ~/.config/hypr/hypridle.conf; then
  osvmarchi-refresh-hypridle
fi
