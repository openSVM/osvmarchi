#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eE

export PATH="$HOME/.local/share/osvmarchi/bin:$PATH"
OSVMARCHI_INSTALL=~/.local/share/osvmarchi/install

# Preparation
source $OSVMARCHI_INSTALL/preflight/show-env.sh
source $OSVMARCHI_INSTALL/preflight/trap-errors.sh
source $OSVMARCHI_INSTALL/preflight/guard.sh
source $OSVMARCHI_INSTALL/preflight/chroot.sh
source $OSVMARCHI_INSTALL/preflight/repositories.sh
source $OSVMARCHI_INSTALL/preflight/migrations.sh
source $OSVMARCHI_INSTALL/preflight/first-run-mode.sh

# Packaging
source $OSVMARCHI_INSTALL/packages.sh
source $OSVMARCHI_INSTALL/packaging/asdcontrol.sh
source $OSVMARCHI_INSTALL/packaging/fonts.sh
source $OSVMARCHI_INSTALL/packaging/lazyvim.sh
source $OSVMARCHI_INSTALL/packaging/webapps.sh
source $OSVMARCHI_INSTALL/packaging/tuis.sh

# Configuration
source $OSVMARCHI_INSTALL/config/config.sh
source $OSVMARCHI_INSTALL/config/theme.sh
source $OSVMARCHI_INSTALL/config/branding.sh
source $OSVMARCHI_INSTALL/config/git.sh
source $OSVMARCHI_INSTALL/config/gpg.sh
source $OSVMARCHI_INSTALL/config/timezones.sh
source $OSVMARCHI_INSTALL/config/increase-sudo-tries.sh
source $OSVMARCHI_INSTALL/config/increase-lockout-limit.sh
source $OSVMARCHI_INSTALL/config/ssh-flakiness.sh
source $OSVMARCHI_INSTALL/config/detect-keyboard-layout.sh
source $OSVMARCHI_INSTALL/config/xcompose.sh
source $OSVMARCHI_INSTALL/config/mise-ruby.sh
source $OSVMARCHI_INSTALL/config/docker.sh
source $OSVMARCHI_INSTALL/config/mimetypes.sh
source $OSVMARCHI_INSTALL/config/localdb.sh
source $OSVMARCHI_INSTALL/config/hardware/network.sh
source $OSVMARCHI_INSTALL/config/hardware/fix-fkeys.sh
source $OSVMARCHI_INSTALL/config/hardware/bluetooth.sh
source $OSVMARCHI_INSTALL/config/hardware/printer.sh
source $OSVMARCHI_INSTALL/config/hardware/usb-autosuspend.sh
source $OSVMARCHI_INSTALL/config/hardware/ignore-power-button.sh
source $OSVMARCHI_INSTALL/config/hardware/nvidia.sh

# Login
source $OSVMARCHI_INSTALL/login/plymouth.sh
source $OSVMARCHI_INSTALL/login/limine-snapper.sh
source $OSVMARCHI_INSTALL/login/alt-bootloaders.sh

# Reboot
clear
tte -i ~/.local/share/osvmarchi/logo.txt --frame-rate 920 laseretch
echo
echo "You're done! So we're ready to reboot now..." | tte --frame-rate 640 wipe

if sudo test -f /etc/sudoers.d/99-osvmarchi-installer; then
  sudo rm -f /etc/sudoers.d/99-osvmarchi-installer &>/dev/null
  echo -e "\nRemember to remove USB installer!\n\n"
fi

sleep 5
reboot
