#!/bin/bash

# Runs on every workspace change: exec-on-workspace-change in ~/.aerospace.toml.
# AeroSpace sets AEROSPACE_FOCUSED_WORKSPACE and AEROSPACE_PREV_WORKSPACE.
#
# 1. Pull the Wispr Flow overlay onto the focused workspace. AeroSpace has no sticky windows.
# 2. Redraw only the two sketchybar items that changed, the workspace left and the one
#    entered, instead of all ten. NON_EMPTY rides along so aerospace.sh does not have to
#    ask the server again.
#
# Every call into the aerospace CLI goes through aero, the guarded wrapper that sketchybar's
# plugins share. This script runs inside the server's own event handling, so an unguarded
# call could wait on the server forever.
source "$HOME/.config/sketchybar/plugins/aerospace_cli.sh"

for id in $(aero list-windows --monitor all --app-bundle-id com.electron.wispr-flow --format '%{window-id}' 2>/dev/null); do
  aero move-node-to-workspace --window-id "$id" "$AEROSPACE_FOCUSED_WORKSPACE" 2>/dev/null
done

NON_EMPTY="$(aero list-workspaces --monitor all --empty no 2>/dev/null | tr '\n' ' ')"

for ws in "$AEROSPACE_FOCUSED_WORKSPACE" "$AEROSPACE_PREV_WORKSPACE"; do
  sketchybar --trigger "aerospace_workspace_change_$ws" \
    FOCUSED_WORKSPACE="$AEROSPACE_FOCUSED_WORKSPACE" NON_EMPTY="$NON_EMPTY" 2>/dev/null &
done
