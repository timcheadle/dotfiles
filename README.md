# Tim Cheadle's dotfiles

Shared config for my Macs (and Linux dev shells), managed with
[chezmoi](https://www.chezmoi.io) and [Homebrew](https://brew.sh).

The old setup lives on the [`archive`](../../tree/archive) branch.

## Docs

- [Shell](docs/shell.md): zsh setup and all aliases
- [Git](docs/git.md): git settings
- [Apps](docs/apps.md): apps and CLI tools in the Brewfile
- [SSH](docs/ssh.md): 1Password SSH agent and keys
- [tmux](docs/tmux.md): sessions and keys
- [Theme](docs/theme.md): Rosé Pine Moon colours and where they are set
- [Decisions](docs/decisions.md): what was chosen and why

## Machine-specific stuff

Nothing work- or machine-specific goes in this repo. Each machine can have
local files that the shared config loads if they exist, such as `~/.gitconfig.local`.
