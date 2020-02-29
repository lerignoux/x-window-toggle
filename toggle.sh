#!/bin/bash

# Toggle a window
window="$1"
# awk remove the window long name and avoid that your browser, shell, ... searching for instance `alacritty` collides with the software
desktop="$(wmctrl -lx | awk '{print $1, $2, $3}' | grep -i "$window" | sed -n 's/0x.*[[:space:]]\([[:digit:]]\)\s.*/\1/p')"
# echo "Switching $window from $desktop"
desktop=$((1 - $desktop))
eval "$(wmctrl -x -r $window -t $desktop)"
if [ "$desktop" -eq "0" ]
then
  eval "$(wmctrl -x -a $window)"
fi
