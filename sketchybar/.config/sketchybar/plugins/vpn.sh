#!/bin/bash

PLUGIN_DIR="$(dirname "$0")"

source "$CONFIG_DIR/colors.sh"

TUNNELS=$(scutil --nc list 2>/dev/null | grep 'com.wireguard.macos')
CONNECTED_TUNNEL=$(echo "$TUNNELS" | grep 'Connected)' | grep -oE '"[^"]+"' | tr -d '"' | head -1)

if [ -n "$CONNECTED_TUNNEL" ]; then
  sketchybar --set "$NAME" icon=󰌾 icon.color=$GREEN label="$CONNECTED_TUNNEL"
else
  sketchybar --set "$NAME" icon=󰿆 icon.color=$RED label=""
fi

# Populate popup with all tunnels
sketchybar --remove '/vpn\.tunnel\..*/' 2>/dev/null

INDEX=0
while IFS= read -r line; do
  [ -z "$line" ] && continue

  TUNNEL_NAME=$(echo "$line" | grep -oE '"[^"]+"' | tr -d '"')
  [ -z "$TUNNEL_NAME" ] && continue

  if echo "$line" | grep -q 'Connected)'; then
    STATUS="Connected"
    ICON="󰌾"
    COLOR=$GREEN
  else
    STATUS="Disconnected"
    ICON="󰿆"
    COLOR=$RED
  fi

  ITEM_ID="vpn.tunnel.$INDEX"

  sketchybar --add item "$ITEM_ID" popup.vpn \
             --set "$ITEM_ID" \
               icon="$ICON" \
               icon.color="$COLOR" \
               icon.font="Hack Nerd Font:Bold:16.0" \
               icon.padding_left=8 \
               label="$TUNNEL_NAME" \
               label.font="Hack Nerd Font:Bold:13.0" \
               label.color=$FG \
               label.padding_right=8 \
               background.height=28 \
               click_script="$PLUGIN_DIR/wireguard_toggle.sh '$TUNNEL_NAME' '$STATUS'; sketchybar --set vpn popup.drawing=off"

  INDEX=$((INDEX + 1))
done <<< "$TUNNELS"
