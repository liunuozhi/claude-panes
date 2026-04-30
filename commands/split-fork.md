---
description: Fork the current Claude Code session into a new Ghostty split pane (optional prompt)
argument-hint: [prompt]
allowed-tools: Bash
disable-model-invocation: true
---

!`"${CLAUDE_PLUGIN_ROOT}/bin/open-ghostty-split.sh" "$PWD" "claude --continue --fork-session" "$ARGUMENTS"`
