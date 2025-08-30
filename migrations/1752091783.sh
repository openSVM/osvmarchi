echo "Install Plymouth splash screen"

sudo pacman -S --needed --noconfirm uwsm plymouth
source "$HOME/.local/share/osvmarchi/install/login/plymouth.sh"
