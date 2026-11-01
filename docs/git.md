# Git

Config: [`dot_gitconfig.tmpl`](../dot_gitconfig.tmpl). Git aliases are in [shell.md](shell.md#git).

## Settings

| Setting | What it does |
|---|---|
| Email by remote | GitLab remotes use the work email; everything else uses the personal email |
| `core.pager = delta` | Colourful diffs with syntax highlighting; `n`/`N` jump between files |
| `init.defaultBranch = main` | New repos start on `main` |
| `push.autoSetupRemote = true` | First push creates and tracks the remote branch |
| `pull.rebase = true` | Pull rebases your commits instead of making merge commits |
| `rebase.autoStash = true` | Pull/rebase works even with uncommitted changes |
| `merge.conflictStyle = zdiff3` | Conflicts also show the original code, so they're easier to read |
| `rerere.enabled = true` | Remembers how you fixed a conflict and reuses the fix (`git rerere forget <file>` to undo) |
| `branch.sort = -committerdate` | `git branch` lists recent branches first |

## Machine-specific

- Name and emails come from `~/.config/chezmoi/chezmoi.toml` (asked on first setup, never committed).
- Anything machine-only goes in `~/.gitconfig.local`, which is loaded if it exists.
- Global ignore file: `~/.config/git/ignore` (read by git automatically).
