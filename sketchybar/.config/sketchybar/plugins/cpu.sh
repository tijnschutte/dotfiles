#!/bin/bash

source "$CONFIG_DIR/colors.sh"

CORES=$(sysctl -n hw.ncpu)
CPU=$(ps -A -o %cpu | awk -v c="$CORES" '{s+=$1} END {printf "%.0f", s/c}')
sketchybar --set "$NAME" label="${CPU}%"

# Populate popup with top 5 CPU-consuming processes
sketchybar --remove '/cpu\.proc\..*/' 2>/dev/null

INDEX=0
while IFS= read -r line; do
  [ -z "$line" ] && continue
  PROC_CPU=$(echo "$line" | awk '{print $1}')
  PROC_NAME=$(echo "$line" | awk '{print $2}')

  sketchybar --add item "cpu.proc.$INDEX" popup.cpu \
             --set "cpu.proc.$INDEX" \
               icon="$PROC_NAME" \
               icon.font="Hack Nerd Font:Regular:13.0" \
               icon.color=$FG \
               icon.padding_left=8 \
               label="${PROC_CPU}%" \
               label.font="Hack Nerd Font:Bold:13.0" \
               label.color=$BLUE \
               label.padding_right=8 \
               background.height=26

  INDEX=$((INDEX + 1))
done <<< "$(ps -Arco %cpu,comm | head -6 | tail -5)"
