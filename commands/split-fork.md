---
description: Fork the current Claude Code session into a new Ghostty split pane (optional prompt)
argument-hint: [prompt]
allowed-tools: Bash
disable-model-invocation: true
---

!`"${CLAUDE_PLUGIN_ROOT}/bin/open-ghostty-split.sh" "$PWD" "claude --continue --fork-session" "$ARGUMENTS"`

The user invoked `/split-fork`, which spawned a new Ghostty split pane running `claude --continue --fork-session` — a fork of the current session. Any prompt argument has already been forwarded to that forked pane and is **not** intended for this session.

Do not analyse the project, run tools, or answer the forwarded prompt. Reply with exactly one short line acknowledging the action (e.g. "Forked session into a new split pane.") and stop.
