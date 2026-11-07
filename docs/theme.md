# Theme: Catppuccin Mocha

Used everywhere. Palette: https://catppuccin.com/palette

| Name | Hex | Used for |
|---|---|---|
| base | `#1e1e2e` | Background, fzf background |
| mantle | `#181825` | tmux status bar |
| surface0 | `#313244` | fzf selected line, tmux borders and messages |
| surface1 | `#45475a` | tmux selection |
| overlay1 | `#7f849c` | Prompt time, tmux clock |
| text | `#cdd6f4` | Main text |
| red | `#f38ba8` | Errors, git status markers, removed lines, fzf matches |
| peach | `#fab387` | tmux current window |
| yellow | `#f9e2af` | Command duration, tmux prefix waiting |
| green | `#a6e3a1` | Prompt `❯` (success), added lines |
| teal | `#94e2d5` | Prompt folder |
| mauve | `#cba6f7` | Git branch, tmux session name |

## Font

Ghostty's built-in **JetBrains Mono**, with ligatures turned off (`font-feature = -calt`, `-liga`, `-dlig`) so `!=` and `=>` stay as typed. Icons come from Ghostty's built-in symbols, so nothing extra is installed.

## Where it's set

| Tool | How | File |
|---|---|---|
| Ghostty | Built-in `Catppuccin Mocha` theme | [`dot_config/ghostty/config`](../dot_config/ghostty/config) |
| starship | `palette = "catppuccin-mocha"` | [`dot_config/starship.toml`](../dot_config/starship.toml) |
| fzf | `FZF_DEFAULT_OPTS` colours | [`dot_zshrc`](../dot_zshrc) |
| delta | Code colours follow the terminal (`syntax-theme = ansi`). Added lines: green `#a6e3a1` on `#323c3f` (changed words bold on `#44554e`). Removed lines: red `#f38ba8` on `#3e2e40` (changed words bold on `#5a3d50`). Backgrounds are base tinted with green or red. | [`dot_gitconfig.tmpl`](../dot_gitconfig.tmpl) |
| tmux | Status bar, borders and messages set directly. Session name is mauve, or yellow while `Ctrl-b` is waiting; current window is peach. | [`dot_config/tmux/tmux.conf`](../dot_config/tmux/tmux.conf) |
| Neovim | `catppuccin` plugin (comes with LazyVim), mocha flavour | [`nvim/lua/plugins/colorscheme.lua`](../nvim/lua/plugins/colorscheme.lua) |
| Claude Code | dark-ansi (terminal colours), messages on `ansi:black` | [`dot_claude/themes/dark-ansi.json`](../dot_claude/themes/dark-ansi.json) |
| `ls`, `grep`, zsh plugins | Follow the terminal's colours automatically | |

Neovim uses the catppuccin plugin (mocha flavour). Claude Code uses dark-ansi, which takes its colours from the terminal; see [claude.md](claude-code.md).
