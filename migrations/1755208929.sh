echo "Change behaviour of XF86PowerOff button to show osvmarchi system menu insead of shutting down immediately"

source $OSVMARCHI_PATH/install/config/hardware/ignore-power-button.sh
setsid systemd-inhibit --what=handle-power-key --why="Temporary disable power button before restart" sleep infinity &
