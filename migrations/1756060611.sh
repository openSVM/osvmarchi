echo "Migrate AUR packages to official repos where possible"

reinstall_package_opr() {
  if pacman -Q $1 >/dev/null; then
    sudo pacman -Rns --noconfirm $1
    sudo pacman -S --noconfirm ${2:-$1}
  fi
}

if pacman -Q yay-bin-debug >/dev/null; then
  sudo pacman -Rns --noconfirm yay-bin-debug
fi

reinstall_package_opr yay-bin yay
reinstall_package_opr obsidian-bin obsidian
reinstall_package_opr localsend-bin localsend
reinstall_package_opr osvmarchi-chromium-bin osvmarchi-chromium
reinstall_package_opr walker-bin
reinstall_package_opr wl-screenrec
reinstall_package_opr python-terminaltexteffects
reinstall_package_opr tzupdate
reinstall_package_opr typora
reinstall_package_opr ttf-ia-writer
