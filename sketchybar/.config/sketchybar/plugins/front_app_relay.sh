#!/bin/bash

# Relay: on front_app_switched, trigger only the focused workspace's event
# so its icon strip updates without waiting for a workspace switch.
source "$CONFIG_DIR/plugins/aerospace_cli.sh"

FOCUSED=$(aero list-workspaces --focused 2>/dev/null)
[ -n "$FOCUSED" ] && sketchybar --trigger aerospace_workspace_change_"$FOCUSED"
