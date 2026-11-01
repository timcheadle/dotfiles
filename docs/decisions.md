# Decisions

Why things are the way they are. Newest at the bottom of each section.
Details of each setup live in the other docs; this is just the reasoning.

## Overall approach

| Decision | Why |
|---|---|
| **chezmoi + Homebrew**, no Nix | Both Macs must be set up the same way. The work Mac (Jamf) only allows 5-minute admin windows, and nix-darwin needs admin on every change. Brew is wanted anyway; chezmoi handles config files with no admin needed. home-manager was considered for locked tool versions, but it duplicates brew. |
| **Mac first**, Linux (kubetops) later | The Mac is what matters day to day. Linux dev shells are a nice-to-have; configs are kept plain so they can be reused there. |
| **Repo is shared stuff only** | Work and personal Macs are nearly identical. Work-specific things go in local files the repo never touches (`~/.zshrc.local`, `~/.gitconfig.local`, `~/.Brewfile.local`), which keeps a public repo safe. |
| **No personal info in the repo** | The repo is public. Name and emails are asked once per machine by chezmoi and stored in `~/.config/chezmoi/chezmoi.toml`. |
| **chezmoi symlink mode**, repo at `~/src/dotfiles` | Editing a config in `~` edits the repo directly. `~/.local/share/chezmoi` is a symlink to the repo, so it's easy to find. Templated files (`.tmpl`) are copied instead and need `chezmoi apply`. |
| **Retire Dropbox/Mackup** | It drifted from the repo, and its symlink approach breaks on modern macOS. |
| **Start fresh** | The old setup (oh-my-zsh, Janus, Vundle, rbenv, Ruby 2.5) is kept on the `archive` branch. |

## Git

| Decision | Why |
|---|---|
| Email picked by remote (GitLab = work) | Works on both Macs with no "which machine is this" setting. |
| delta for diffs | Readable, syntax-highlighted diffs; replaces vimdiff. |
| `pull.rebase`, `rebase.autoStash`, `zdiff3`, `rerere`, `autoSetupRemote` | Modern defaults that remove common friction. |
| No `fetch.prune` | Personal preference: keep remote branches until deleted on purpose. |
| Aliases chosen from shell history | Kept only what's actually used (`gco`, `gc`, `gs`, `gpl`, `gp`, `gd`…), plus a few useful additions. `gb` is now blame; the old `gb` (branch) is `gbr`. |
| Sign all commits with the 1Password SSH key | Verified commits on GitHub, no separate GPG key. Mac only, since it uses 1Password's signer. GitLab needs the key added there (at work). |

## Shell

| Decision | Why |
|---|---|
| Plain zsh, no oh-my-zsh | Faster and easier to understand; only the needed bits. |
| Plugins via brew, no plugin manager | Only 1 real plugin (autosuggestions); one `brew upgrade` updates everything. Switch to antidote if the list grows past ~5. |
| starship, two-line prompt | Time, folder, branch + status, duration. Only listed modules are shown, so it stays fast (~35ms). Language and cloud modules are off for speed. |
| `❯` turns red on failure, no exit code shown | Personal preference: subtle is enough. |
| Per-tab history | Each tab keeps its own history until it closes; commands are still saved right away. |
| Miller (`mlr`) replaces csvfix and the Ruby `csvhead` script | Actively maintained and does the same jobs; `csvhead` is now a shell function. |
| mise for Ruby and Node, no global versions | Replaces rbenv/asdf: faster, reads old `.ruby-version` / `.nvmrc` files. Existing projects use older versions, so global "latest" wouldn't help. |
| uv for Python | The modern standard for Python; avoids mise and uv both managing Python. |
| No syntax highlighting plugin | Colouring commands as you type was distracting, even toned down. |
| Built-in `ls`/`grep` colours, not eza/bat | Keep it simple and safe on Linux. eza/bat can be added later, aliased only if installed. |
| Dropped: Ansible, AWS, Ruby/bundler plugins, postgres@10, themekit, `~/.bin` | No longer used. |

## Look and feel

| Decision | Why |
|---|---|
| Rosé Pine Moon everywhere | Personal preference. Set in each tool; anything using the terminal's 16 colours follows automatically. See [theme.md](theme.md). |
| JetBrains Mono, ligatures off | Compared JetBrains Mono, Hack and Input. Liked JetBrains Mono's line height and letterforms (Hack's "i" looked odd), but not operator ligatures, so those are off. Built into Ghostty, so nothing to install. |
| Ghostty as the terminal (trying it out) | Modern and fast, with the theme and Nerd Font icons built in. iTerm2 still works with the same prompt. |
| No Ghostty quick terminal (drop-down) | Not needed; Alfred covers quick launching. |
| Ghostty: subtle transparency (0.95, blur 20), extra padding | kunchenguid's 0.8 / 50 was far too see-through. Coloured backgrounds are made see-through too so diffs match. |

## Apps and tools

| Decision | Why |
|---|---|
| Kept from old Brewfile: `gh`, `jq`, `mas`, `nmap`, `watch` | Still used. `mas` lets the Brewfile install App Store apps. |
| Dropped: ansible, awscli, gnu-tar, heroku, redis, rbenv, ruby-build, mackup, the_silver_searcher | Not used anymore, or replaced (mise, ripgrep, chezmoi). Per-project services like redis get added when a project needs them. |
| Neovim instead of vim | Switching to nvim overall. Its config is still to do. |
| Apps installed with brew, including ones first installed by hand (adopted) | One list, one update command, and a new Mac gets everything. |
| Slack from brew, not the App Store | Consistent with the other apps, and new Macs don't depend on an App Store sign-in. Cost: one admin step to remove the App Store copy. |
| Rectangle Pro, not Rectangle | The paid version is what's actually used. |

## SSH

| Decision | Why |
|---|---|
| SSH keys live in 1Password (agent), new ed25519 key for GitHub | No key files on disk, Touch ID to use, same keys on every Mac. |
| Old key files kept for now | It's not yet known which servers use them. Import into 1Password or retire later. |
| Server hosts in `~/.ssh/config.local`, not the repo | The repo is public; host names and addresses are private. |
| 1Password agent line is Mac-only | Linux machines don't have it; the line would break ssh there. |

## tmux

| Decision | Why |
|---|---|
| tmux, not Zellij | Mainly for keeping sessions alive (e.g. on kubetops). tmux is the standard and is everywhere. |
| Default prefix `Ctrl-b` | Matches guides online. |
| Few, guessable keys (`\|`, `-`, arrows, `z`, `c`, `x`) and the mouse on | Easier to build muscle memory. The status bar shows when the prefix is active. |
| No `Ctrl-1`..`9` window switching | Those keys are used by macOS. |
| No plugin manager | The config is small; Rosé Pine colours are set directly. |

## Neovim

| Decision | Why |
|---|---|
| LazyVim (trial) | Works well out of the box with a key menu, so it's easy to discover. Might turn out to be too much; we'll see. |
| Whole `~/.config/nvim` linked to `nvim/` in the repo | Neovim writes its plugin lock file there, so it gets saved in the repo too. |
| Keep the starter's Apache LICENSE in `nvim/` | It covers the copied starter files; harmless. |
| Command line at the bottom | Classic vim habit; the centred pop-up felt odd. |
| Removed the leftover macOS 27 beta SDK | It broke all compiling (syntax parsers, gems, brew builds). Fixed properly rather than worked around. |

## macOS

| Decision | Why |
|---|---|
| One settings script, run by chezmoi on change | Both Macs match; no admin needed. |
| Keep existing trackpad, mouse and Dock look | Already set how they're liked; recorded so new Macs match. |
| Dock: no delay, no recent apps; pinned apps managed with `dockutil` | Faster, tidier, and a new Mac gets the same Dock. iTerm replaced by Ghostty. Serato stays in the Dock but not the Brewfile. |
| Keyboard: no autocorrect, smart quotes/dashes or double-space full stop | They break code and commands. |
| Finder: keep the extension-change warning | Personal preference. |
| Spotlight on Option+Space, Alfred on Cmd+Space; Ctrl+1–9 and Ctrl+arrows for desktops | Existing habits, now recorded. |
| Light mode, no hot corners, screenshots on the Desktop, volume sound and startup chime on | Personal preference. The chime is the macOS default, so no admin step is needed. |
| Alfred syncs via iCloud Drive, not Dropbox or the repo | Dropbox is being retired; iCloud is built in. Alfred data can be personal, so not in a public repo. |

## New Mac setup

| Decision | Why |
|---|---|
| One-command `install.sh`, run with `bash -c "$(curl ...)"` | A fresh Mac goes from nothing to set up. This form keeps the terminal interactive, so Homebrew's password prompt and chezmoi's questions work (`curl \| bash` breaks them). |
| `chezmoi apply` runs `brew bundle --no-upgrade` when the Brewfile changes | Both Macs stay in sync automatically; upgrades stay a separate, deliberate `brew upgrade`. |
| Manual checklist for 1Password, App Management, `gh auth`, Alfred | These need sign-ins or privacy approvals that can't be scripted. |

## Still to decide

- More apps (old App Store list), and which work apps come from Jamf
- AI agent config (AGENTS.md, Claude settings, skills)
- Linux / kubetops setup
