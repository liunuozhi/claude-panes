---
description: Fork the current Claude Code session into a new Ghostty split pane (new session id, same history)
allowed-tools: Bash
disable-model-invocation: true
---

!`"${CLAUDE_PLUGIN_ROOT}/bin/open-ghostty-split.sh" "$PWD" $'claude --continue --fork-session\n'`
