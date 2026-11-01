# Neovim

[LazyVim](https://www.lazyvim.org), started from its official starter. Config lives in [`nvim/`](../nvim) in the repo, and `~/.config/nvim` is a symlink to it, so the plugin lock file (`nvim/lazy-lock.json`) is saved in the repo and both Macs get the same plugin versions.

Helper tools (in the Brewfile): `ripgrep`, `fd`, `lazygit`, `tree-sitter-cli`.

## Changes from stock LazyVim

| Change | File | Why |
|---|---|---|
| Rosé Pine Moon colour scheme | [`lua/plugins/colorscheme.lua`](../nvim/lua/plugins/colorscheme.lua) | Matches everything else |
| Command line at the bottom (not a pop-up) | [`lua/plugins/ui.lua`](../nvim/lua/plugins/ui.lua) | Classic vim feel; the rest of noice stays |

## Keys to start with

`Space` is the leader key; pause after it and a menu shows what's next.

| Keys | Does |
|---|---|
| `Space Space` | Find a file by name |
| `Space /` | Search text in all files |
| `Space e` | File tree |
| `Space g g` | lazygit |
| `s` | Flash jump: type a couple of letters, then the label to jump there |
| `:q` | Quit |

## Search and replace

| Command | Does |
|---|---|
| `:s/foo/bar/g` | Current line only |
| `:%s/foo/bar/g` | Whole file (`%` = every line) |
| `V` select, then `:s/foo/bar/g` | Selected lines (`:'<,'>` is filled in) |

Matches and replacements preview live as you type; Esc cancels.

## Troubleshooting

- **"Failed to compile parser" errors on start**: the Mac's developer tools can't build. Check `xcrun --show-sdk-path`; a beta SDK newer than macOS (e.g. `MacOSX27*.sdk` in `/Library/Developer/CommandLineTools/SDKs/`) can break the linker. Remove it with `sudo rm -rf` (needs admin).
- `:checkhealth` reports anything else missing.
- `:Lazy` shows plugins; `:Lazy sync` updates them (and the lock file).
