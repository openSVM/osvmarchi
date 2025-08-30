echo "Update fastfetch config with new OSVMarchi logo"

osvmarchi-refresh-config fastfetch/config.jsonc

mkdir -p ~/.config/osvmarchi/branding
cp $OSVMARCHI_PATH/icon.txt ~/.config/osvmarchi/branding/about.txt
