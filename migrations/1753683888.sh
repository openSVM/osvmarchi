echo "Adding OSVMarchi version info to fastfetch"
if ! grep -q "osvmarchi" ~/.config/fastfetch/config.jsonc; then
  cp ~/.local/share/osvmarchi/config/fastfetch/config.jsonc ~/.config/fastfetch/
fi

