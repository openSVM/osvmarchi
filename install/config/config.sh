#!/bin/bash

# Copy over OSVMarchi configs
mkdir -p ~/.config
cp -R ~/.local/share/osvmarchi/config/* ~/.config/

# Use default bashrc from OSVMarchi
cp ~/.local/share/osvmarchi/default/bashrc ~/.bashrc
