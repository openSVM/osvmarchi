echo "Replace volume control GUI with a TUI"

if ! command -v wiremix &>/dev/null; then
  sudo pacman -S --noconfirm --needed wiremix
  sudo pacman -Rns --noconfirm pavucontrol

  osvmarchi-refresh-applications
  osvmarchi-refresh-waybar
fi
