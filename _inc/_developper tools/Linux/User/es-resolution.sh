#!/bin/bash

choice=$(zenity --list --text="Emulationstation résolution :" --column="Option" --column="Description" \
  "FULL-SCREEN" "Plein écran" \
  "w-720P" "1280x720" \
  "w-VGA" "640x480" \
  "w-43" "1280x960" \
  "w-54" "1280x1024" \
  "w-ODROID" "480x320" \
  "w-219" "1680x720" \
  "w-VERTICAL" "1680x720" )

resolution=""

case $choice in
  "w-VGA") resolution="--windowed --resolution  640 480" ;;
  "w-ODROID") resolution="--windowed --resolution 480 320" ;;
  "w-54") resolution="--windowed --resolution 1280 1024" ;;
  "w-43") resolution="--windowed --resolution 1280 960" ;;
  "w-720P") resolution="--windowed --resolution 1280 720" ;;
  "w-219") resolution="--windowed --resolution 1680 720" ;;
  "w-VERTICAL") resolution="--windowed --resolution 576 1024" ;;
  "FULL-SCREEN") resolution="--fullscreen" ;;
  *) exit 0 ;;
esac

gnome-terminal -- bash -c "cd $HOME/batocera-emulationstation && ./emulationstation.sh $resolution"

