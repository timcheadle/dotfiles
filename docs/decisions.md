# Decisions

Why things are the way they are. Details of each setup live in the other docs.

## Overall approach

| Decision | Why |
|---|---|
| **chezmoi + Homebrew**, no Nix | Both Macs are set up the same way. The work Mac (Jamf) only allows 5-minute admin windows, and nix-darwin needs admin on every change. chezmoi needs no admin; brew handles apps and tools. |
| **Mac first**, Linux (kubetops) later | The Mac is the daily machine. Configs are plain files so they can be reused on Linux. |
| **Repo is shared stuff only** | Work and personal Macs are nearly identical. Work-specific things go in local files the repo never touches (`~/.zshrc.local`, `~/.gitconfig.local`, `~/.Brewfile.local`), which keeps a public repo safe. |
| **No personal info in the repo** | The repo is public. Name and emails are asked once per machine by chezmoi and stored in `~/.config/chezmoi/chezmoi.toml`. |
| **chezmoi symlink mode**, repo at `~/src/dotfiles` | Editing a config in `~` edits the repo directly. `~/.local/share/chezmoi` links to the repo so it's easy to find. Templated files (`.tmpl`) are copied and need `chezmoi apply`. |
| **No Dropbox or Mackup** | Everything lives in the repo or in each app's own sync. |
| **Default branch is `main`** | Modern default; matches `init.defaultBranch = main`. The pre-2020 setup is on the `archive` branch. |

## Git

| Decision | Why |
|---|---|
| Email picked by remote (GitLab = work) | Works on both Macs with no "which machine is this" setting. |
| delta for diffs | Readable, syntax-highlighted diffs. |
| `pull.rebase`, `rebase.autoStash`, `zdiff3`, `rerere`, `autoSetupRemote` | Modern defaults that remove common friction. |
| No `fetch.prune` | Keep remote branches until deleted on purpose. |
| Short aliases for the commands actually used | `gs`, `gd`, `gco`, `gc`… are fast to type. `gb` is blame and `gbr` is branch. |
| Sign all commits with the 1Password SSH key | Verified commits on GitHub, no separate GPG key. Mac only, since it uses 1Password's signer. GitLab needs the key added there. |

## Shell

| Decision | Why |
|---|---|
| Plain zsh, no oh-my-zsh | Faster and easier to understand; only the needed bits. |
| Plugins via brew, no plugin manager | Only one real plugin (autosuggestions); one `brew upgrade` updates everything. Switch to antidote if the list grows past ~5. |
| starship, two-line prompt | Time, folder, branch + status, duration. Only listed modules are shown, so it stays fast (~35ms). |
| `❯` turns red on failure, no exit code shown | Subtle is enough. |
| Per-tab history | Each tab keeps its own history until it closes; commands are still saved right away. |
| No syntax highlighting while typing | Colouring commands as you type is distracting. |
| Built-in `ls`/`grep` colours, not eza/bat | Simple and safe on Linux. eza/bat can be added later, aliased only if installed. |
| Miller (`mlr`) for CSV/TSV/JSON | Actively maintained toolkit; `csvhead` is a small shell function on top. |
| mise for Ruby and Node, no global versions | Fast, and reads existing `.ruby-version` / `.nvmrc` files. Each project pins its own version. |
| uv for Python | The modern standard for Python; keeps mise and uv from both managing Python. |

## Look and feel

| Decision | Why |
|---|---|
| Rosé Pine Moon everywhere | Soothing palette. Set in each tool; anything using the terminal's 16 colours follows automatically. See [theme.md](theme.md). |
| JetBrains Mono, ligatures off | Clear letterforms and comfortable line height; operators like `!=` stay as typed. Built into Ghostty, so nothing to install. |
| Ghostty as the terminal | Modern and fast, with the theme and icons built in. |
| Ghostty: subtle transparency (0.95, blur 20), extra padding | Just enough depth without distraction. Coloured backgrounds are see-through too, so diffs match. |
| No Ghostty quick terminal | Alfred covers quick launching. |

## Apps and tools

| Decision | Why |
|---|---|
| Every app and tool in the Brewfile, including ones installed by hand (adopted) | One list, one update command, and a new Mac gets everything. |
| Slack from brew, not the App Store | Consistent with the other apps; new Macs don't depend on an App Store sign-in. |
| Rectangle Pro | The paid version is the one in use. |
| Neovim as the editor | `vi` and `vim` open it; `EDITOR` is `nvim`. |
| Project services (redis, postgres…) aren't global | Added per project when needed. |

## SSH

| Decision | Why |
|---|---|
| SSH keys live in 1Password (agent), ed25519 key for GitHub | No key files on disk, Touch ID to use, same keys on every Mac. |
| Older key files stay in `~/.ssh` until migrated | Not yet known which servers use them. |
| Server hosts in `~/.ssh/config.local`, not the repo | The repo is public; host names and addresses are private. |
| 1Password agent line is Mac-only | Linux machines don't have it; the line would break ssh there. |

## tmux

| Decision | Why |
|---|---|
| tmux, not Zellij | Mainly for keeping sessions alive (e.g. on kubetops). tmux is the standard and is everywhere. |
| Default prefix `Ctrl-b` | Matches guides online. |
| Few, guessable keys (`\|`, `-`, arrows, `z`, `c`, `x`) and the mouse on | Easier to build muscle memory. The status bar shows when the prefix is active. |
| No `Ctrl-1`..`9` window switching | macOS uses those keys for desktops. |
| No plugin manager | The config is small; colours are set directly. |

## Neovim

| Decision | Why |
|---|---|
| LazyVim | Works well out of the box, and the key menu makes it easy to discover. |
| Whole `~/.config/nvim` linked to `nvim/` in the repo | Neovim writes its plugin lock file there, so it's saved in the repo too. |
| Starter's Apache LICENSE kept in `nvim/` | It covers the copied starter files. |
| Command line at the bottom | Classic vim position; noice's other features stay. |

## macOS

| Decision | Why |
|---|---|
| One settings script, run by chezmoi on change | Both Macs match; no admin needed. |
| Trackpad, mouse and Dock look recorded as they are | New Macs match the current feel. |
| Dock: no delay, no recent apps, pinned apps via `dockutil` | Faster, tidier, and a new Mac gets the same Dock. Apps not installed are skipped. |
| Keyboard: no autocorrect, smart quotes/dashes or double-space full stop | They break code and commands. |
| Finder: extension-change warning on | Avoids renaming mistakes. |
| Spotlight on Option+Space, Alfred on Cmd+Space; Ctrl+1–9 and Ctrl+arrows for desktops | Muscle memory. |
| Light mode, no hot corners, screenshots on the Desktop, volume sound and startup chime on | Personal preference. The chime is the macOS default, so no admin step is needed. |
| Alfred syncs via iCloud Drive, not the repo | iCloud is built into every Mac. Alfred data can be personal, so it stays out of a public repo. |

## New Mac setup

| Decision | Why |
|---|---|
| One-command `install.sh`, run with `bash -c "$(curl ...)"` | A fresh Mac goes from nothing to set up. This form keeps the terminal interactive, so Homebrew's password prompt and chezmoi's questions work (`curl \| bash` breaks them). |
| `chezmoi apply` runs `brew bundle --no-upgrade` when the Brewfile changes | Both Macs stay in sync automatically; upgrades stay a separate, deliberate `brew upgrade`. |
| Manual checklist for 1Password, App Management, `gh auth`, Alfred | These need sign-ins or privacy approvals that can't be scripted. |

## Claude Code

| Decision | Why |
|---|---|
| Shared `settings.json` in the repo | Both Macs get the same model, thinking, display and theme. |
| No status hooks | Ghostty shows Claude's status itself. |
| One personal instructions file (`agents/AGENTS.md`) shared by Claude Code and Codex | Edit once, every tool follows it. |
| Theme: dark-ansi with darker message backgrounds | Code is coloured with the terminal's Rosé Pine palette. ANSI themes only allow the 16 terminal colours, so diffs keep their built-in look. |

## Still to decide

- Which work apps come from Jamf
- Skills (none of your own yet)
- Linux / kubetops setup
