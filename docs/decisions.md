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
| Commit signing: later | Will use the 1Password SSH key once SSH is set up. |

## Shell

| Decision | Why |
|---|---|
| Plain zsh, no oh-my-zsh | Faster and easier to understand; only the needed bits. |
| Plugins via brew, no plugin manager | Only 2 real plugins (autosuggestions, syntax highlighting); one `brew upgrade` updates everything. Switch to antidote if the list grows past ~5. |
| starship, two-line prompt | Time, folder, branch + status, duration. Only listed modules are shown, so it stays fast (~35ms). Language and cloud modules are off for speed. |
| `❯` turns red on failure, no exit code shown | Personal preference: subtle is enough. |
| Per-tab history | Each tab keeps its own history until it closes; commands are still saved right away. |
| Miller (`mlr`) replaces csvfix and the Ruby `csvhead` script | Actively maintained and does the same jobs; `csvhead` is now a shell function. |
| mise for Ruby and Node, no global versions | Replaces rbenv/asdf: faster, reads old `.ruby-version` / `.nvmrc` files. Existing projects use older versions, so global "latest" wouldn't help. |
| uv for Python | The modern standard for Python; avoids mise and uv both managing Python. |
| Built-in `ls`/`grep` colours, not eza/bat | Keep it simple and safe on Linux. eza/bat can be added later, aliased only if installed. |
| Dropped: Ansible, AWS, Ruby/bundler plugins, postgres@10, themekit, `~/.bin` | No longer used. |

## Look and feel

| Decision | Why |
|---|---|
| Rosé Pine Moon everywhere | Personal preference. Set in each tool; anything using the terminal's 16 colours follows automatically. See [theme.md](theme.md). |
| Ghostty as the terminal (trying it out) | Modern and fast, with the theme and Nerd Font icons built in. iTerm2 still works with the same prompt. |

## Apps and tools

| Decision | Why |
|---|---|
| Kept from old Brewfile: `gh`, `jq`, `mas`, `nmap`, `watch` | Still used. `mas` lets the Brewfile install App Store apps. |
| Dropped: ansible, awscli, gnu-tar, heroku, redis, rbenv, ruby-build, mackup, the_silver_searcher | Not used anymore, or replaced (mise, ripgrep, chezmoi). Per-project services like redis get added when a project needs them. |
| Neovim instead of vim | Switching to nvim overall. Its config is still to do. |
| Apps installed with brew, including ones first installed by hand (adopted) | One list, one update command, and a new Mac gets everything. |
| Slack from brew, not the App Store | Consistent with the other apps, and new Macs don't depend on an App Store sign-in. Cost: one admin step to remove the App Store copy. |
| Rectangle Pro, not Rectangle | The paid version is what's actually used. |

## Still to decide

- More apps (old App Store list), and which work apps come from Jamf
- SSH keys via 1Password, and commit signing
- Neovim config, tmux, fonts
- macOS settings script
- AI agent config (AGENTS.md, Claude settings, skills)
- Linux / kubetops setup
