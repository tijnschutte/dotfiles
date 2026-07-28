#!/bin/bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/icon_map.sh"

WORKSPACE_ID="$1"

# Always query fresh to avoid race conditions during rapid switching
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)

# Resolve non-empty workspaces: env var from trigger, or query aerospace
if [ -z "$NON_EMPTY" ]; then
  NON_EMPTY=$(aerospace list-workspaces --monitor all --empty no 2>/dev/null | tr '\n' ' ')
fi

# Build app icon strip for non-empty workspaces
build_icon_strip() {
  local ws="$1"
  local apps strip=""
  apps=$(aerospace list-windows --workspace "$ws" 2>/dev/null | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')
  if [ -n "$apps" ]; then
    while IFS= read -r APP; do
      APP="${APP#"${APP%%[![:space:]]*}"}"
      APP="${APP%"${APP##*[![:space:]]}"}"
      [ -z "$APP" ] && continue
      __icon_map "$APP"
      strip+=" $icon_result"
    done <<< "$apps"
  fi
  echo "$strip"
}

if [ "$WORKSPACE_ID" = "$FOCUSED_WORKSPACE" ]; then
  # Focused: highlighted with app icons
  ICON_STRIP=$(build_icon_strip "$WORKSPACE_ID")

  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=$BLUE \
    background.border_width=0 \
    icon.color=$BG_DARK \
    icon.font="Hack Nerd Font:Bold:17.0" \
    label.drawing=on \
    label.color=$BG_DARK \
    label="$ICON_STRIP"
elif echo " $NON_EMPTY " | grep -q " $WORKSPACE_ID "; then
  # Occupied: subtle background with border + app icons
  ICON_STRIP=$(build_icon_strip "$WORKSPACE_ID")

  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=$BRACKET_BG \
    background.border_width=1 \
    background.border_color=$COMMENT \
    icon.color=$FG \
    icon.font="Hack Nerd Font:Bold:17.0" \
    label.drawing=on \
    label.color=$COMMENT \
    label="$ICON_STRIP"
else
  # Empty: dimmed
  sketchybar --set "$NAME" \
    background.drawing=off \
    background.border_width=0 \
    icon.color=$COMMENT \
    icon.font="Hack Nerd Font:Regular:14.0" \
    label.drawing=off \
    label=""
fi
