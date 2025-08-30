echo "Add new matte black theme"

if [[ ! -L "~/.config/osvmarchi/themes/matte-black" ]]; then
  ln -snf ~/.local/share/osvmarchi/themes/matte-black ~/.config/osvmarchi/themes/
fi
