echo "Add OSVMarchi Package Repository"

if ! grep -q "omarchy" /etc/pacman.conf; then
  sudo sed -i '/^\[core\]/i [omarchy]\nSigLevel = Optional TrustAll\nServer = https:\/\/pkgs.osvm.archi\/$arch\/\n' /etc/pacman.conf
  sudo systemctl restart systemd-timesyncd
  sudo pacman -Syu --noconfirm
fi
