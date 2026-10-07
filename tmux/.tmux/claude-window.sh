#!/bin/sh
# Opens a tmux window from the prefix-c prompt.
#   $1  folder keyword typed at the prompt (may be empty)
#   $2  path of the pane the prompt was opened from
#   $3  tmux client that opened the prompt, so the miss message lands on its status line
#
# With a keyword: resolve it the way `z` would and start Claude Code there, window named
# after the folder. Without one, or when zoxide has no match: open a plain shell in the
# current path with a blank name, so the tab shows only its number.
keyword=$1
here=$2
client=$3

if [ -n "$keyword" ]; then
  # $keyword is deliberately unquoted: `z code tijn` passes two keywords, and so does this.
  # shellcheck disable=SC2086
  if dir=$(zoxide query -- $keyword 2>/dev/null); then
    # Flag spelled out: tmux runs this through a non-interactive shell, which never loads
    # the zshrc alias that adds it. Window closes when Claude exits.
    exec tmux new-window -c "$dir" -n "$(basename "$dir")" "claude --dangerously-skip-permissions"
  fi
  tmux display-message ${client:+-c "$client"} "zoxide: no match for '$keyword', opening a shell instead"
fi

exec tmux new-window -c "$here" -n ''
