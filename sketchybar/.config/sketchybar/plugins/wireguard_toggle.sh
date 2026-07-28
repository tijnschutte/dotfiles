#!/bin/bash

# Toggle a WireGuard tunnel on/off via scutil
# $1 = tunnel name, $2 = current status (Connected/Disconnected)

TUNNEL="$1"
STATUS="$2"

if [ "$STATUS" = "Connected" ]; then
  scutil --nc stop "$TUNNEL"
else
  scutil --nc start "$TUNNEL"
fi

# Brief pause for state to update, then force vpn script to re-run
sleep 1
sketchybar --set vpn script="$CONFIG_DIR/plugins/vpn.sh" --update
