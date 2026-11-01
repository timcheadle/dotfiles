# tmux

Config: [`dot_config/tmux/tmux.conf`](../dot_config/tmux/tmux.conf).

## Sessions (the main reason to use it)

| Command | Does |
|---|---|
| `tmux` | Start a new session |
| `tmux new -s work` | Start a session named "work" |
| `tmux a` | Reattach to the last session |
| `tmux a -t work` | Reattach to "work" |
| `tmux ls` | List sessions |

Closing the terminal window doesn't stop tmux: sessions keep running until you exit them or the machine restarts.

## Keys

Press `Ctrl-b`, let go, then the key. The session name in the bottom left turns **gold** while tmux is waiting for that key.

| Key | Does |
|---|---|
| `\|` | Split side by side |
| `-` | Split top and bottom |
| arrow keys | Move between panes |
| `z` | Zoom pane to full screen and back |
| `x` | Close pane (asks first) |
| `c` | New window (like a tab) |
| `1`–`9` | Go to window |
| `n` / `p` | Next / previous window |
| `l` | Last window (toggle back and forth) |
| `w` | Pick a window from a list |
| `,` | Rename window |
| `d` | Detach (session keeps running) |
| `s` | Pick a session |
| `r` | Reload this config |
| `?` | List all keys |

New panes and windows open in the current folder.

## Mouse

On: click a pane to select it, click a window name in the status bar to switch, drag a border to resize, scroll to see history.

## Other settings

| Setting | Why |
|---|---|
| Windows and panes numbered from 1 | Matches the keyboard |
| Windows renumber when one closes | No gaps |
| 50,000 lines of history | |
| `escape-time 10` | No delay after Esc in nvim |
| `allow-passthrough`, `focus-events`, `extended-keys` | Claude Code works inside tmux: Shift+Enter, notifications |
| Status bar and borders | Rosé Pine Moon |
