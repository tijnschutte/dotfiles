#!/bin/bash

source "$CONFIG_DIR/colors.sh"

TOTAL_MEM=$(sysctl -n hw.memsize)
TOTAL_GB=$(echo "$TOTAL_MEM" | awk '{printf "%.0f", $1/1073741824}')
PAGE_SIZE=$(sysctl -n hw.pagesize)
USED=$(vm_stat | awk -v total="$TOTAL_MEM" -v ps="$PAGE_SIZE" '
  /Pages active/                {a=$NF+0}
  /Pages wired/                 {w=$NF+0}
  /Pages occupied by compressor/ {c=$NF+0}
  END {printf "%.0f", (a+w+c)*ps/total*100}
')
USED_GB=$(vm_stat | awk -v ps="$PAGE_SIZE" '
  /Pages active/                {a=$NF+0}
  /Pages wired/                 {w=$NF+0}
  /Pages occupied by compressor/ {c=$NF+0}
  END {printf "%.1f", (a+w+c)*ps/1073741824}
')

PRESSURE=$(memory_pressure | awk '/System-wide memory free percentage/ {print $NF+0}')
if [ "$PRESSURE" -ge 50 ]; then
  PCOLOR=$GREEN
elif [ "$PRESSURE" -ge 25 ]; then
  PCOLOR=$YELLOW
else
  PCOLOR=$RED
fi

sketchybar --set "$NAME" label="${USED}% ${PRESSURE}%f" label.color=$PCOLOR

# Populate popup with top 5 memory-consuming processes
sketchybar --remove '/memory\.proc\..*/' 2>/dev/null

# Header: used / total
sketchybar --add item "memory.proc.header" popup.memory \
           --set "memory.proc.header" \
             icon="${USED_GB}G / ${TOTAL_GB}G" \
             icon.font="Hack Nerd Font:Bold:13.0" \
             icon.color=$GREEN \
             icon.padding_left=8 \
             label.drawing=off \
             background.height=26

INDEX=0
while IFS= read -r line; do
  [ -z "$line" ] && continue
  PROC_MEM=$(echo "$line" | awk '{print $1}')
  PROC_NAME=$(echo "$line" | awk '{print $2}')

  sketchybar --add item "memory.proc.$INDEX" popup.memory \
             --set "memory.proc.$INDEX" \
               icon="$PROC_NAME" \
               icon.font="Hack Nerd Font:Regular:13.0" \
               icon.color=$FG \
               icon.padding_left=8 \
               label="${PROC_MEM}" \
               label.font="Hack Nerd Font:Bold:13.0" \
               label.color=$GREEN \
               label.padding_right=8 \
               background.height=26

  INDEX=$((INDEX + 1))
done <<< "$(ps -Amco rss,comm | head -6 | tail -5 | awk '{printf "%.0fM %s\n", $1/1024, $2}')"
