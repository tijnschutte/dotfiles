#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Detect WiFi connection via scutil
IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)

if [ -n "$IP_ADDRESS" ]; then
  ICON=󰖩
  COLOR=$BLUE
else
  ICON=󰖪
  COLOR=$COMMENT
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label=""
