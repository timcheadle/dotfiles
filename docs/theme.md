# Theme: Rosé Pine Moon

Used everywhere. Palette: https://rosepinetheme.com/palette

| Name | Hex | Used for |
|---|---|---|
| base | `#232136` | Background |
| surface | `#2a273f` | |
| overlay | `#393552` | fzf selected line |
| muted | `#6e6a86` | Prompt time |
| subtle | `#908caa` | fzf text |
| text | `#e0def4` | Main text |
| love | `#eb6f92` | Errors, git status markers |
| gold | `#f6c177` | Command duration |
| rose | `#ea9a97` | fzf matches |
| pine | `#3e8fb0` | Prompt `❯` (success) |
| foam | `#9ccfd8` | Prompt folder |
| iris | `#c4a7e7` | Git branch |

## Font

Ghostty's built-in **JetBrains Mono**, with ligatures turned off (`font-feature = -calt`, `-liga`, `-dlig`) so `!=` and `=>` stay as typed. Icons come from Ghostty's built-in symbols, so nothing extra is installed.

## Where it's set

| Tool | How | File |
|---|---|---|
| Ghostty | Built-in `Rose Pine Moon` theme | [`dot_config/ghostty/config`](../dot_config/ghostty/config) |
| starship | `palette = "rose-pine-moon"` | [`dot_config/starship.toml`](../dot_config/starship.toml) |
| fzf | `FZF_DEFAULT_OPTS` colours | [`dot_zshrc`](../dot_zshrc) |
| delta | Code colours follow the terminal (`syntax-theme = ansi`). Added lines: green text `#a6da95` on `#263838` (changed words bold on `#34574a`). Removed lines: love `#eb6f92` on `#382536` (changed words bold on `#5a2f47`). The green is outside the palette, chosen to sit well on it. | [`dot_gitconfig.tmpl`](../dot_gitconfig.tmpl) |
| tmux | Status bar, borders and messages set directly. Session name is iris, or gold while `Ctrl-b` is waiting; current window is rose. | [`dot_config/tmux/tmux.conf`](../dot_config/tmux/tmux.conf) |
| Neovim | `rose-pine` plugin, moon variant | [`nvim/lua/plugins/colorscheme.lua`](../nvim/lua/plugins/colorscheme.lua) |
| Claude Code | dark-ansi (terminal colours), messages on `ansi:black` | [`dot_claude/themes/dark-ansi.json`](../dot_claude/themes/dark-ansi.json) |
| `ls`, `grep`, zsh plugins | Follow the terminal's colours automatically | |

Neovim uses the rose-pine plugin (moon variant). Claude Code uses dark-ansi, which takes its colours from the terminal; see [claude.md](claude-code.md).
