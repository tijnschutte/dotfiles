#!/bin/sh
# Shottr: Cmd+Shift+5 captures the clicked window (copied to clipboard, Shottr's default).
# Not a stow package: run once per machine. Re-run after a Shottr update if the hotkey stops working.
set -e

# Free Cmd+Shift+5 from macOS's screenshot/recording toolbar (symbolic hotkey 184).
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 184 \
  '{enabled = 0; value = { parameters = (53, 23, 1179648); type = standard; }; }'
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Shottr writes its prefs on quit, so it must be closed while we edit them.
osascript -e 'quit app "Shottr"'
sleep 2
# carbonKeyCode 23 = "5", carbonModifiers 768 = Cmd+Shift. Key name found in the Shottr binary, not documented.
defaults write cc.ffitch.shottr KeyboardShortcuts_window -string '{"carbonKeyCode":23,"carbonModifiers":768}'
defaults write cc.ffitch.shottr afterGrabCopy -bool true
open -a Shottr
