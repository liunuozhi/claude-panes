#!/usr/bin/env bash
# Open a Ghostty split pane at the given cwd and type the given input.
# Usage: open-ghostty-split.sh <cwd> [input]
set -euo pipefail

cwd="${1:?cwd required}"
input="${2:-}"

osascript \
    -e 'on run argv' \
    -e '    tell application "Ghostty"' \
    -e '        set cfg to new surface configuration' \
    -e '        set initial working directory of cfg to (item 1 of argv)' \
    -e '        if (count of argv) > 1 then' \
    -e '            set initial input of cfg to (item 2 of argv)' \
    -e '        end if' \
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
