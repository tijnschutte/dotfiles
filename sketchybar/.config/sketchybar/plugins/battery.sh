#!/bin/sh

source "$CONFIG_DIR/colors.sh"

BATT_INFO="$(pmset -g batt)"
PERCENTAGE="$(echo "$BATT_INFO" | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(echo "$BATT_INFO" | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  100)        ICON="󰁹"; COLOR=$GREEN ;;
  9[0-9])     ICON="󰂂"; COLOR=$GREEN ;;
  8[0-9])     ICON="󰂁"; COLOR=$GREEN ;;
  7[0-9])     ICON="󰂀"; COLOR=$GREEN ;;
  6[0-9])     ICON="󰁿"; COLOR=$GREEN ;;
  5[0-9])     ICON="󰁾"; COLOR=$YELLOW ;;
  4[0-9])     ICON="󰁽"; COLOR=$YELLOW ;;
  3[0-9])     ICON="󰁼"; COLOR=$YELLOW ;;
  2[0-9])     ICON="󰁻"; COLOR=$RED ;;
  1[0-9])     ICON="󰁺"; COLOR=$RED ;;
  *)          ICON="󰂎"; COLOR=$RED ;;
esac

if [ "$CHARGING" != "" ]; then
  ICON="󰂄"
  COLOR=$CYAN
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%" label.color="$COLOR"
