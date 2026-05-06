# claude-panes

A Claude Code plugin that opens [Ghostty](https://ghostty.org) split panes running Claude Code from your current session.

> **Scope:** macOS + Ghostty only. The split is driven through Ghostty's AppleScript dictionary via `osascript`, so other terminals (iTerm2, WezTerm, Kitty, Alacritty…) and other operating systems are not supported.

## Commands

- **`/split-new [prompt]`** — Open a new Ghostty split pane in the current working directory and start a fresh `claude` session. If `[prompt]` is given, it is passed to `claude` as the initial prompt.
- **`/split-fork [prompt]`** — Open a new Ghostty split pane and fork the current session into it (`claude --continue --fork-session`). Both panes share history up to the fork point, then diverge. If `[prompt]` is given, it is sent as the next user turn in the forked session.
- **`/create-new [prompt]`** — Same as `/split-new`, but opens a new Ghostty tab in the front window instead of splitting the current pane.
- **`/create-fork [prompt]`** — Same as `/split-fork`, but opens the forked session in a new Ghostty tab instead of a split pane.

> **Note on quoting:** the prompt is wrapped in `"..."` and typed into the new pane verbatim — embedding literal double quotes in your prompt will break the wrapping. For prompts with quotes, type them in the new pane after it opens.

## Requirements

- macOS (uses AppleScript)
- [Ghostty](https://ghostty.org)
- [Claude Code](https://docs.claude.com/claude-code)

## Install

From inside Claude Code, add the marketplace and install the plugin:

```
/plugin marketplace add liunuozhi/claude-panes
/plugin install claude-panes@claude-panes
```

Confirm with `/plugin`.

## How it works

Each command shells out to a small script in `bin/`, which runs an `osascript` snippet that talks to Ghostty's AppleScript dictionary:

1. Build a `new surface configuration` with the current cwd as `initial working directory`.
2. Set `initial input` to `<cmd>\n` (or `<cmd> "<prompt>"\n` if a prompt was given), where `<cmd>` is `claude` or `claude --continue --fork-session`.
3. Either `split` the focused terminal of the front window to the right with that configuration (`open-ghostty-split.sh`), or open a `new tab` in the front window with it (`open-ghostty-tab.sh`). Both variants fall back to `new window` if no Ghostty window is open.

That's the whole mechanism — no session-file copying, no daemons. Forking is delegated to Claude Code's built-in `--fork-session` flag.

## Development

Local layout:

```
.claude-plugin/
  plugin.json
  marketplace.json
bin/
  open-ghostty-split.sh
  open-ghostty-tab.sh
commands/
  split-new.md
  split-fork.md
  create-new.md
  create-fork.md
```

Validate manifests:

```bash
claude plugin validate /path/to/claude-panes
```

Hot-reload story:

| Edit | Reload step |
|---|---|
| `bin/*.sh` | None — re-read on every invocation |
| `commands/*.md` | `/reload-plugins` |
| `plugin.json`, `marketplace.json` | `/reload-plugins` |

Errors don't surface in the TUI — start with `claude --debug` and tail `~/.claude/logs/debug.log`.

## Credits

The Ghostty-split mechanism is adapted from [`extensions/split-fork.ts`](https://github.com/mitsuhiko/agent-stuff/blob/main/extensions/split-fork.ts) in [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff), which originally implemented this for the pi-coding-agent. This plugin reuses the AppleScript pattern and adapts it to Claude Code's `--fork-session` flag.

## License

MIT
