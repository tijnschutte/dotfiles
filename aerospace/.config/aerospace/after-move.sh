#!/bin/bash

# Runs after alt-shift-N moves a window: exec-on-workspace-change does not fire on a move,
# so redraw the target workspace ($1) and the focused one ourselves.
source "$HOME/.config/sketchybar/plugins/aerospace_cli.sh"

sketchybar --trigger "aerospace_workspace_change_$1"
sketchybar --trigger "aerospace_workspace_change_$(aero list-workspaces --focused 2>/dev/null)"
