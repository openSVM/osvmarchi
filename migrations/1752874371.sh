echo "Add Catppuccin Latte light theme"
if [[ ! -L "~/.config/osvmarchi/themes/catppuccin-latte" ]]; then
  ln -snf ~/.local/share/osvmarchi/themes/catppuccin-latte ~/.config/osvmarchi/themes/
fi
