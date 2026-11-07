# Git

Config: [`dot_gitconfig.tmpl`](../dot_gitconfig.tmpl). Git aliases are in [shell.md](shell.md#git).

## Settings

| Setting | What it does |
|---|---|
| One email per Mac | Asked on first setup, so the work Mac uses the work email and the personal Mac the personal one |
| `core.pager = delta` | Colourful diffs with syntax highlighting; `n`/`N` jump between files |
| `init.defaultBranch = main` | New repos start on `main` |
| `push.autoSetupRemote = true` | First push creates and tracks the remote branch |
| `pull.rebase = true` | Pull rebases your commits instead of making merge commits |
| `rebase.autoStash = true` | Pull/rebase works even with uncommitted changes |
| `merge.conflictStyle = zdiff3` | Conflicts also show the original code, so they're easier to read |
| `rerere.enabled = true` | Remembers how you fixed a conflict and reuses the fix (`git rerere forget <file>` to undo) |
| `branch.sort = -committerdate` | `git branch` lists recent branches first |
| No commit signing | Off, since each laptop has its own keys. To turn it on for one Mac, add `user.signingkey`, `gpg.format = ssh` and `commit.gpgsign = true` to `~/.gitconfig.local`. |

## Machine-specific

- Name and email come from `~/.config/chezmoi/chezmoi.toml` (asked on first setup, never committed).
- Anything machine-only goes in `~/.gitconfig.local`, which is loaded if it exists.
- Global ignore file: `~/.config/git/ignore` (read by git automatically).
