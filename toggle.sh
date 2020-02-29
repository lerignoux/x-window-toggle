#!/bin/bash

# Toggle a window
window="$1"
desktop="$(wmctrl -lx | grep -i "$window" | awk '{$5=""}1' | sed -n 's/0x.*[[:space:]]\([[:digit:]]\)\s.*/\1/p')"
# echo "Switching $window from $desktop"
desktop=$((1 - $desktop))
eval "$(wmctrl -x -r $window -t $desktop)"
if [ "$desktop" -eq "0" ]
then
  eval "$(wmctrl -x -a $window)"
fi
