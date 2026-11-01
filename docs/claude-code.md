# Claude Code

Settings: [`dot_claude/settings.json`](../dot_claude/settings.json), linked as `~/.claude/settings.json`, so changes made with `/config` are saved in the repo.

| Setting | Value | Why |
|---|---|---|
| `model` | `opus` | The most capable model |
| `alwaysThinkingEnabled` | true | Better results on harder tasks |
| `tui` | `fullscreen` | Smooth, flicker-free display; scroll inside Claude |
| `theme` | `custom:dark-ansi` | See below |
| `enabledPlugins` | `frontend-design` | Better-looking web and UI work |

No hooks: Ghostty shows Claude's status (working, waiting) by itself.

## Theme

[`dot_claude/themes/dark-ansi.json`](../dot_claude/themes/dark-ansi.json): built-in **Dark mode (ANSI colors only)**, with your messages on the terminal's darkest grey (`ansi:black`) instead of a light grey. Pick it with `/theme`.

What we learned while trying other themes:

| Limit | Effect |
|---|---|
| ANSI themes only use the terminal's 16 colours | Custom hex colours get rounded, usually to grey. Use `ansi:<name>` values instead. |
| Each theme family has fixed code colours | Dark = Monokai (yellow strings), Light = dark code text, ANSI = terminal palette. A custom theme inherits them from its `base`. |
| Only diff *backgrounds* can be customised | Diff text colours can't be changed. |

## Not in the repo

- `~/.claude/skills/synced/`: skills synced from the claude.ai account; Claude manages these.
- Sessions, history, credentials and other runtime files in `~/.claude/`.
