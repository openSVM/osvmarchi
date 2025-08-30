echo "Start screensaver automatically after 1 minute and stop before locking"

if ! grep -q "osvmarchi-launch-screensaver" ~/.config/hypr/hypridle.conf; then
  osvmarchi-refresh-hypridle
  osvmarchi-refresh-hyprlock
fi
