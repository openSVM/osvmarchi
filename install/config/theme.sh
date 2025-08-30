#!/bin/bash

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"

# Setup theme links
mkdir -p ~/.config/osvmarchi/themes
for f in ~/.local/share/osvmarchi/themes/*; do ln -nfs "$f" ~/.config/osvmarchi/themes/; done

# Set initial theme
mkdir -p ~/.config/osvmarchi/current
ln -snf ~/.config/osvmarchi/themes/tokyo-night ~/.config/osvmarchi/current/theme
ln -snf ~/.config/osvmarchi/current/theme/backgrounds/1-scenery-pink-lakeside-sunset-lake-landscape-scenic-panorama-7680x3215-144.png ~/.config/osvmarchi/current/background

# Set specific app links for current theme
ln -snf ~/.config/osvmarchi/current/theme/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

mkdir -p ~/.config/btop/themes
ln -snf ~/.config/osvmarchi/current/theme/btop.theme ~/.config/btop/themes/current.theme

mkdir -p ~/.config/mako
ln -snf ~/.config/osvmarchi/current/theme/mako.ini ~/.config/mako/config
