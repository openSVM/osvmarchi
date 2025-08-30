#!/bin/bash

# OSVMarchi logo in a font for Waybar use
mkdir -p ~/.local/share/fonts
cp ~/.local/share/osvmarchi/config/osvmarchi.ttf ~/.local/share/fonts/
fc-cache
