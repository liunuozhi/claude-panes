#!/usr/bin/env bash
# Open a Ghostty split pane at <cwd> and type "<cmd>" or "<cmd> \"<prompt>\"".
# Usage: open-ghostty-split.sh <cwd> <cmd> [prompt]
set -euo pipefail

cwd="${1:?cwd required}"
cmd="${2:?cmd required}"
prompt="${3:-}"

if [ -n "$prompt" ]; then
    input="$cmd \"$prompt\""$'\n'
else
    input="$cmd"$'\n'
fi

osascript \
    -e 'on run argv' \
    -e '    tell application "Ghostty"' \
    -e '        set cfg to new surface configuration' \
    -e '        set initial working directory of cfg to (item 1 of argv)' \
    -e '        set initial input of cfg to (item 2 of argv)' \
    -e '        if (count of windows) > 0 then' \
    -e '            try' \
    -e '                split (focused terminal of selected tab of front window) direction right with configuration cfg' \
    -e '            on error' \
    -e '                new window with configuration cfg' \
    -e '            end try' \
    -e '        else' \
    -e '            new window with configuration cfg' \
    -e '        end if' \
    -e '        activate' \
    -e '    end tell' \
    -e 'end run' \
    "$cwd" "$input"
