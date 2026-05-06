---
description: Fork the current Claude Code session into a new Ghostty tab (optional prompt)
argument-hint: [prompt]
allowed-tools: Bash
disable-model-invocation: true
---

!`"${CLAUDE_PLUGIN_ROOT}/bin/open-ghostty-tab.sh" "$PWD" "claude --continue --fork-session" "$ARGUMENTS"`

The user invoked `/create-fork`, which spawned a new Ghostty tab running `claude --continue --fork-session` — a fork of the current session. Any prompt argument has already been forwarded to that forked tab and is **not** intended for this session.

Do not analyse the project, run tools, or answer the forwarded prompt. Reply with exactly one short line acknowledging the action (e.g. "Forked session into a new Ghostty tab.") and stop.
