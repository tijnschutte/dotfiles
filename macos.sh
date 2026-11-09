#!/bin/bash
# macOS settings the rest of this repo assumes. Safe to re-run.
# "Displays have separate Spaces" only changes after logging out.
set -euo pipefail

# Menu bar: hidden, sketchybar draws its own.
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Dock: auto-hide, appears instantly, small, no recent apps.
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15
defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string scale

# AeroSpace recommendations: windows of one app grouped in Mission Control (its
# off-screen windows otherwise render tiny), Spaces never reorder themselves, and
# displays share one Space so AeroSpace controls all monitors. Last one needs a logout.
defaults write com.apple.dock expose-group-apps -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.spaces spans-displays -bool true

# Clicking the wallpaper doesn't sweep all windows away (Sonoma+ default does).
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Snappier windows: no open/zoom animation, near-instant sheet resize.
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

killall Dock
killall SystemUIServer
echo "Done. Log out and back in for the Spaces/displays change."
