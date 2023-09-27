#!/bin/bash

choice=$(zenity --list --text="Emulationstation résolution :" --column="Option" --column="Description" \
  "1" "640x480" \
  "2" "480x320" \
  "3" "Plein écran")

resolution=""

case $choice in
  "1") resolution="--windowed --resolution  640 480" ;;
  "2") resolution="--windowed --resolution 480 320" ;;
  "3") resolution="--fullscreen" ;;
  *) exit 0 ;;
esac

gnome-terminal -- bash -c "cd $HOME/batocera-emulationstation && ./emulationstation.sh $resolution"

