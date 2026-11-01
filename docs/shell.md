# Shell

zsh, set up without a framework (no oh-my-zsh). Config: [`dot_zshrc`](../dot_zshrc).
Everything is installed with brew (see [`Brewfile`](../Brewfile)).

## Tools and plugins

| Tool | What it does | How to use |
|---|---|---|
| starship | Prompt | Automatic |
| zsh-autosuggestions | Grey suggestion from history as you type | `→` accepts it |
| fzf | Fuzzy search | `Ctrl-R` history, `Ctrl-T` files, `Alt-C` cd into folder |
| zoxide | Jump to folders you use often | `z proj` jumps to the best match for "proj" |
| mise | Ruby and Node versions per project | In a project, `mise install` installs what it asks for |
| uv | Python versions, virtual environments and packages | See below |

## Languages

There are no global versions; each project pins its own.

### Ruby and Node (mise)

Config: [`dot_config/mise/config.toml`](../dot_config/mise/config.toml).

- mise reads `.ruby-version`, `.nvmrc`, `.tool-versions` and `mise.toml`.
- In a project: `mise install` installs the pinned versions, and they switch on automatically when you `cd` in.
- Pin a version in a new project: `mise use ruby@3.3`.
- Add a global default later: `mise use -g node@lts`.

### Python (uv)

uv replaces pip, venv, pyenv, pipx and poetry.

| Task | Command |
|---|---|
| New project | `uv init` |
| Add a package | `uv add requests` |
| Run something in the project | `uv run python script.py` |
| Pin a Python version | `uv python pin 3.12` (writes `.python-version`) |
| One-off script with dependencies | `uv run --with requests script.py` |
| Install a CLI tool globally | `uv tool install ruff` |

## Prompt

Config: [`dot_config/starship.toml`](../dot_config/starship.toml).

```
12:00 ~/src/dotfiles on  revamp [!?] took 12s
❯
```

| Part | Notes |
|---|---|
| Time | 24-hour, when the prompt was drawn |
| Folder | Up to 4 levels deep |
| Branch + status | Markers like `!` changed, `?` untracked, `⇡` ahead |
| `took 12s` | Only appears for commands that take 2s or more |
| `❯` | Green after success, red after failure |

Only these parts are shown, so the prompt stays fast (about 35ms). Language versions and cloud info are off on purpose. Run `starship timings` to see what's slow.

## History

- Each tab keeps its own history until it closes. Commands are saved to `~/.zsh_history` immediately, so new tabs see everything.
- Keeps 100,000 entries; skips repeated commands.
- Start a command with a space to keep it out of history (handy for secrets).

## Colours

Built-in colours only: `ls` (via `CLICOLOR` on macOS, `--color=auto` on Linux) and `grep --color=auto`.

## Completion

Tab completion is case-insensitive, and pressing Tab twice opens a menu you can move through with the arrow keys.

## Aliases

Defined in [`dot_config/zsh/aliases.zsh`](../dot_config/zsh/aliases.zsh).

### Git

| Alias | Command | Why |
|---|---|---|
| `gs` | `git status -sb` | Short status, plus branch and ahead/behind |
| `gp` | `git push` | First push sets up the remote automatically (`push.autoSetupRemote`) |
| `gpf` | `git push --force-with-lease` | Safe force-push after a rebase; refuses if someone else pushed |
| `gpl` | `git pull` | Rebases instead of merging (`pull.rebase`), stashes uncommitted work (`rebase.autoStash`) |
| `gl` | `git log --oneline --graph --decorate -20` | Last 20 commits, one line each, with branch lines |
| `gd` | `git diff` | Shown through delta |
| `gds` | `git diff --staged` | What you're about to commit |
| `gb` | `git blame -w -C -C -C` | Ignores whitespace, follows code moved or copied between files |
| `gbr` | `git branch` | List branches (most recent first) |
| `gco` | `git checkout` | Switch branches or restore files |
| `gcb` | `git switch -c` | Create and switch to a new branch |
| `ga` | `git add` | |
| `gap` | `git add -p` | Pick changes piece by piece |
| `gc` | `git commit -v` | Shows the diff in the commit message editor |
| `gcan` | `git commit --amend --no-edit` | Add forgotten changes to the last commit |
| `gst` | `git stash` | |
| `gstp` | `git stash pop` | |

### Data

| Alias | Command | Why |
|---|---|---|
| `csvhead [delim]` | `mlr --icsv --oxtab head -n 1` | Each column header next to its first value. Reads stdin: `csvhead < file.csv`, or `csvhead ';' < file.csv` |

Miller (`mlr`) is the general CSV/TSV/JSON tool, replacing csvfix:

| Task | Command |
|---|---|
| Pick/reorder columns | `mlr --csv cut -o -f city,name file.csv` |
| Drop a column | `mlr --csv cut -x -f email file.csv` |
| Filter rows | `mlr --csv filter '$name == "Tim"' file.csv` |
| Sort | `mlr --csv sort -f email file.csv` |
| Unique rows | `mlr --csv uniq -a file.csv` |
| Join | `mlr --csv join -j id -f other.csv file.csv` |
| Summary stats | `mlr --csv summary file.csv` |
| CSV to JSON | `mlr --icsv --ojson cat file.csv` |

## Machine-specific

Machine-only aliases, paths and environment variables go in `~/.zshrc.local`, which is loaded if it exists.
