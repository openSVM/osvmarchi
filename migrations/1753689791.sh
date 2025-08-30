echo "Add the new ristretto theme as an option"

if [[ ! -L ~/.config/osvmarchi/themes/ristretto ]]; then
  ln -nfs ~/.local/share/osvmarchi/themes/ristretto ~/.config/osvmarchi/themes/
fi
