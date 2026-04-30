# claude-panes

A Claude Code plugin that opens [Ghostty](https://ghostty.org) split panes running Claude Code from your current session.

## Commands

- **`/split-new`** — Open a new Ghostty split pane in the current working directory and start a fresh `claude` session.
- **`/split-fork`** — Open a new Ghostty split pane and fork the current session into it (`claude --continue --fork-session`). Both panes share history up to the fork point, then diverge.

## Requirements

- macOS (uses AppleScript)
- [Ghostty](https://ghostty.org)
- [Claude Code](https://docs.claude.com/claude-code)

## Install

```bash
claude plugin marketplace add /path/to/claude-panes
claude plugin install claude-panes@claude-panes-dev
```

Confirm with `claude plugin list`.

## How it works

Each command shells out to `bin/open-ghostty-split.sh`, which runs an `osascript` snippet that talks to Ghostty's AppleScript dictionary:

1. Build a `new surface configuration` with the current cwd as `initial working directory`.
2. Set `initial input` to either `claude\n` or `claude --continue --fork-session\n`.
3. `split` the focused terminal of the front window to the right with that configuration. If no window is open, fall back to `new window`.

That's the whole mechanism — no session-file copying, no daemons. Forking is delegated to Claude Code's built-in `--fork-session` flag.

## Development

Local layout:

```
.claude-plugin/
  plugin.json
  marketplace.json
bin/open-ghostty-split.sh
commands/
  split-new.md
  split-fork.md
```

Validate manifests:

```bash
claude plugin validate /path/to/claude-panes
```

Hot-reload story:

| Edit | Reload step |
|---|---|
| `bin/open-ghostty-split.sh` | None — re-read on every invocation |
| `commands/*.md` | `/reload-plugins` |
| `plugin.json`, `marketplace.json` | `/reload-plugins` |

Errors don't surface in the TUI — start with `claude --debug` and tail `~/.claude/logs/debug.log`.

## Credits

The Ghostty-split mechanism is adapted from [`extensions/split-fork.ts`](https://github.com/mitsuhiko/agent-stuff/blob/main/extensions/split-fork.ts) in [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff), which originally implemented this for the pi-coding-agent. This plugin reuses the AppleScript pattern and adapts it to Claude Code's `--fork-session` flag.

## License

MIT
