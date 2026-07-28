#!/bin/bash

DISK=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')
sketchybar --set "$NAME" label="${DISK}%"
sketchybar --push "$NAME" "$( echo "$DISK" | awk '{printf "%.2f", $1/100}' )"
