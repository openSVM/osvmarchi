#!/bin/bash

ansi_art='   ____   ____   _   _   __  __     _                 _         
  / __ \ / __ \ | \ | | |  \/  |   | |     ___    __| |  ___   
 | |  | | |  | ||  \| | | |\/| |   | |    / _ \  / _` | / _ \  
 | |__| | |__| || |\  | | |  | |   | |___| (_) || (_| ||  __/  
  \____/ \____/ |_| \_| |_|  |_|   |______\___/  \__,_| \___|  
                O S V M A R C H I                              '

clear
echo -e "\n$ansi_art\n"

sudo pacman -Syu --noconfirm --needed git

# Use custom repo if specified, otherwise default to openSVM/osvmarchy
OSVMARCHI_REPO="${OSVMARCHI_REPO:-openSVM/osvmarchy}"

echo -e "\nCloning OSVMarchi from: https://github.com/${OSVMARCHI_REPO}.git"
rm -rf ~/.local/share/osvmarchi/
git clone "https://github.com/${OSVMARCHI_REPO}.git" ~/.local/share/osvmarchi >/dev/null

# Use custom branch if instructed, otherwise default to master
OSVMARCHI_REF="${OSVMARCHI_REF:-master}"
if [[ $OSVMARCHI_REF != "master" ]]; then
  echo -e "\eUsing branch: $OSVMARCHI_REF"
  cd ~/.local/share/osvmarchi
  git fetch origin "${OSVMARCHI_REF}" && git checkout "${OSVMARCHI_REF}"
  cd -
fi

echo -e "\nInstallation starting..."
source ~/.local/share/osvmarchi/install.sh
