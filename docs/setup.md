# Setting up a new Mac

## 1. Run the installer

In Terminal (the built-in one is fine):

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/timcheadle/dotfiles/main/install.sh)"
```

| Step | What happens | Admin? |
|---|---|---|
| Homebrew | Installs Homebrew and Apple's developer tools | **Yes**: asks for your password once. On the work Mac, use a Jamf admin window. |
| chezmoi | `brew install chezmoi` | No |
| Repo | Clones to `~/src/dotfiles` (or pulls the latest if already there), links `~/.local/share/chezmoi` to it | No |
| Existing `~/.zshrc` | Moved to `~/.zshrc.local`, which the new `.zshrc` loads at the end. If `~/.zshrc.local` already exists, it's saved as `~/.zshrc.pre-dotfiles` instead. | No |
| Questions | Name and this Mac's git email (stored in `~/.config/chezmoi/chezmoi.toml`, never in the repo) | No |
| Apps and tools | `brew bundle` installs everything in the [`Brewfile`](../Brewfile), plus `~/.Brewfile.local` if this Mac has one | A few apps may ask for your password |
| Configs | zsh, git, tmux, Ghostty, Neovim, starship, mise | No |
| macOS settings | Keyboard, trackpad, Dock, Finder, shortcuts, Alfred | No |

The installer is safe to run again; finished steps are skipped.

**Work Mac:** start the Jamf admin window, **then open a new Terminal tab**, then run the installer. A tab opened before the admin window can still turn down your password.

## 2. Things that can't be scripted

The installer checks steps 3 and 4 at the end and only lists them if they're still to do.

1. **Sign in** to 1Password, and to the CLIs you use there (`gh auth login`, `glab auth login`).
2. **App Management**: if macOS asks, allow **Ghostty**, so brew can update apps from it. Ghostty only shows up in System Settings → Privacy & Security → App Management after macOS has asked.
3. **Alfred**: with iCloud, wait for iCloud Drive to download the `Alfred` folder. Without iCloud (work Mac), open Alfred once. Then run `dotfiles-update`.
4. **Log out and back in** so keyboard settings take effect (only needed when the macOS settings changed).
5. **This Mac only**: put its own things in `~/.zshrc.local`, `~/.gitconfig.local` and `~/.Brewfile.local`. SSH isn't managed by this repo. If the old `.zshrc` was moved to `~/.zshrc.local`, remove anything that clashes with the repo setup (oh-my-zsh, another prompt), since it loads last and wins.

## Keeping Macs in sync

| Task | Command |
|---|---|
| Rerun the full installer (pull, apps, configs) | `dotfiles-update` |
| Pull and apply the latest repo | `chezmoi update` |
| Apply local edits to templates | `chezmoi apply` |
| Upgrade apps and tools | `brew upgrade` |
| Add an app | Add it to the Brewfile, then `chezmoi apply` (runs `brew bundle` when the Brewfile changes) |

Most configs are symlinks into the repo, so editing them edits the repo directly. Templated files (`.tmpl`, like the git config) need `chezmoi apply` after editing.
