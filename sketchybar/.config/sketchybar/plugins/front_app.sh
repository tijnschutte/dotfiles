#!/bin/sh

case "$SENDER" in
  front_app_switched)
    if [ -n "$INFO" ]; then
      sketchybar --set "$NAME" label="$INFO"
    fi
    ;;
  aerospace_workspace_change)
    WINDOW_COUNT=$(aerospace list-windows --workspace focused 2>/dev/null | wc -l | tr -d ' ')
    if [ "$WINDOW_COUNT" -eq 0 ]; then
      sketchybar --set "$NAME" label=""
    else
      FRONT_APP=$(aerospace list-windows --workspace focused --format '%{app-name}' 2>/dev/null | head -1)
      sketchybar --set "$NAME" label="$FRONT_APP"
    fi
    ;;
esac
