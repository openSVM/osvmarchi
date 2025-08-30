echo "Add UWSM env"

export OSVMARCHI_PATH="$HOME/.local/share/osvmarchi"
export PATH="$OSVMARCHI_PATH/bin:$PATH"

mkdir -p "$HOME/.config/uwsm/"
osvmarchi-refresh-config uwsm/env

echo -e "\n\e[31mOSVMarchi bins have been added to PATH (and OSVMARCHI_PATH is now system-wide).\nYou must immediately relaunch Hyprland or most OSVMarchi cmds won't work.\nPlease run OSVMarchi > Update again after the quick relaunch is complete.\e[0m"
echo

gum confirm "Ready to relaunch Hyprland? (All applications will be closed)" &&
  touch ~/.local/state/osvmarchi/migrations/1751134560.sh &&
  uwsm stop
