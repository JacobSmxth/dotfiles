#!/bin/bash

choices=" Lock\n Logout\n Reboot\n Shutdown\n Suspend"

action=$(printf "$choices" | wofi \
  --conf ~/.config/wofi/powerConfig \
  --style ~/.config/wofi/power.css \
  --dmenu)

case $action in
  " Lock") hyprlock ;;
  " Logout") hyprctl dispatch exit ;;
  " Reboot") systemctl reboot ;;
  " Shutdown") systemctl poweroff ;;
  " Suspend") systemctl suspend ;;
esac

