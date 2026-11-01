# Ghostty

Config: [`dot_config/ghostty/config`](../dot_config/ghostty/config). Reload with **Cmd+Shift+,**. See every option with `ghostty +show-config --default --docs`.

| Setting | Value | Why |
|---|---|---|
| `theme` | Rose Pine Moon | Built in; see [theme.md](theme.md) |
| Font | JetBrains Mono (built in), ligatures off | `!=` and `=>` stay as typed |
| `window-padding-x` / `-y` | 10 / 8, balanced | A little breathing room around text |
| `background-opacity` | 0.95 | Subtly see-through |
| `background-blur` | 20 | Soft blur behind the window |
| `background-opacity-cells` | true | Coloured backgrounds (diff lines, tmux bar) are see-through too, so they match |

## Notes

- Comments must be on their own line; `key = value  # comment` is an error.
- Some changes (like opacity) may only show in a new window.
- brew needs Ghostty to have **App Management** permission (System Settings → Privacy & Security) to update or adopt apps.
