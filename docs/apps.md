# Apps and tools

Everything is in the [`Brewfile`](../Brewfile). Install or update with `brew bundle --file=~/src/dotfiles/Brewfile`.

## Apps

| App | What it's for |
|---|---|
| 1Password | Passwords, SSH keys |
| Alfred | Launcher |
| Claude | Claude Desktop |
| Claude Code | Claude Code CLI |
| Ghostty | Terminal |
| Google Chrome | Browser |
| Numi | Calculator |
| Rectangle Pro | Window snapping |
| Slack | |
| Spotify | |
| Vorssaint | Menu bar: keep-awake, system monitor, volume mixer |

## CLI tools

| Tool | What it's for |
|---|---|
| `delta` | Nicer git diffs |
| `mlr` (Miller) | CSV/TSV/JSON toolkit |
| `mise` | Ruby and Node versions per project |
| `uv` | Python versions, venvs, packages |
| `gh` | GitHub CLI |
| `jq` | JSON on the command line |
| `mas` | App Store apps from the Brewfile |
| `nmap` | Network scanner |
| `watch` | Rerun a command every 2s |
| `nvim` | Editor |
| `mole` | Mac cleanup |
| `osxphotos` | Export and query Apple Photos (from the `rhettbull/osxphotos` tap) |

Shell tools (starship, fzf, zoxide, zsh plugins) are covered in [shell.md](shell.md).

## Adding apps

- Add the app to the Brewfile and run `brew bundle`, rather than using `brew install` directly. Otherwise the next Mac won't get it.
- If the app is already installed by hand, use `brew install --cask --adopt <name>` so brew takes it over.
- The terminal needs **App Management** permission (System Settings → Privacy & Security) for brew to update or adopt apps.
- App Store copies are owned by the system, so switching one to brew means deleting it first (`sudo rm -rf /Applications/<App>.app`, which needs admin) and signing in to the app again.
