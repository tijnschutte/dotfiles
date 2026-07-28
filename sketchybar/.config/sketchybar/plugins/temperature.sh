#!/bin/bash

source "$CONFIG_DIR/colors.sh"

TEMP_FILE="/tmp/smctemp/cpu_temperature.txt"

# Display cached value immediately
if [ -f "$TEMP_FILE" ]; then
  TEMP=$(awk '{printf "%.0f", $1}' "$TEMP_FILE")
else
  TEMP="–"
fi

COLOR=$GREEN
if [ "$TEMP" != "–" ]; then
  if [ "$TEMP" -ge 80 ]; then
    COLOR=$RED
  elif [ "$TEMP" -ge 60 ]; then
    COLOR=$YELLOW
  fi
fi

sketchybar --set "$NAME" label="${TEMP}°" \
                         icon.color=$COLOR \
                         label.color=$COLOR

# Refresh cache in background for next update (~5s, runs async)
/opt/homebrew/bin/smctemp -c -i25 -n180 -f &
