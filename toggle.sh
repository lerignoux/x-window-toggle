#!/bin/bash

# Toggle a window
window="$1"
# awk remove the window long name and avoid that your browser, shell, ... searching for instance `alacritty` collides with the software
window_info="$(wmctrl -lx | awk '{print $1, $2, $3}' | grep -i "$window")"
window_desktop="$(echo "$window_info" | sed -n 's/0x.*[[:space:]]\([[:digit:]]\)\s.*/\1/p')"
window_id="$(echo "$window_info" | awk '{print $1}')"
# echo "Switching $window from $desktop"
window_desktop=$((1 - $window_desktop))
eval "$(wmctrl -x -r $window -t $window_desktop)"
if [ "$window_desktop" -eq "0" ]
then
  eval "$(wmctrl -R $window)"
  eval "$(xdotool windowraise $window_id)"
  eval "$(xdotool windowfocus $window_id)"
fi
