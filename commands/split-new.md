---
description: Open a fresh Claude Code session in a Ghostty split pane (optional prompt)
argument-hint: [prompt]
allowed-tools: Bash
disable-model-invocation: true
---

!`"${CLAUDE_PLUGIN_ROOT}/bin/open-ghostty-split.sh" "$PWD" "claude" "$ARGUMENTS"`

The user invoked `/split-new`, which spawned a new Ghostty split pane running a fresh `claude` session. Any prompt argument has already been forwarded to that new pane and is **not** intended for this session.

Do not analyse the project, run tools, or answer the forwarded prompt. Reply with exactly one short line acknowledging the action (e.g. "Opened a new split pane.") and stop.
