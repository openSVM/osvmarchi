echo "Switch to OSVMarchi Chromium for synchronized theme switching"

set_theme_colors() {
  if [[ -f ~/.config/osvmarchi/current/theme/chromium.theme ]] && command -v chromium &>/dev/null; then
    chromium --no-startup-window --set-theme-color="$(<~/.config/osvmarchi/current/theme/chromium.theme)"
  else
    # Use a default, neutral grey if theme doesn't have a color
    chromium --no-startup-window --set-theme-color="28,32,39"
  fi
}

if command -v chromium &>/dev/null; then
  sudo pacman -Rns --noconfirm chromium || true
  sudo pacman -S --noconfirm osvmarchi-chromium

  if pgrep -x chromium; then
    if gum confirm "Chromium must be restarted. Ready?"; then
      pkill -x chromium
      set_theme_colors
    fi
  else
    set_theme_colors
  fi
fi
