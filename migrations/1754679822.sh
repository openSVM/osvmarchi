echo "Lock 1password on screen lock"

if ! grep -q "osvmarchi-lock-screen" ~/.config/hypr/hypridle.conf; then
  osvmarchi-refresh-hypridle
fi
