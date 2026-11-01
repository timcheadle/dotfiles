# macOS settings

Script: [`.chezmoiscripts/run_onchange_after_macos-defaults.sh.tmpl`](../.chezmoiscripts/run_onchange_after_macos-defaults.sh.tmpl). chezmoi runs it on `chezmoi apply` whenever the file changes (Mac only). No admin needed. Some settings take effect after logging out and back in.

To find the setting behind a checkbox: `defaults read > before.txt`, change it in System Settings, `defaults read > after.txt`, then `diff before.txt after.txt`.

## Keyboard

| Setting | Value |
|---|---|
| Key repeat | Fastest (2) |
| Delay before repeat | Short (15) |
| Holding a key | Repeats it (no accent pop-up) |
| Autocorrect, auto-capitalise, smart quotes, smart dashes, double-space full stop | Off |
| Tab moves between all controls | On |

## Trackpad and mouse

| Setting | Value |
|---|---|
| Tap to click | On |
| Two-finger right click | On |
| Click firmness | Medium |
| Three-finger drag | Off |
| Trackpad speed | 0.6875 |
| Mouse speed | 0.875 |
| Natural scrolling | Off |

## Dock

| Setting | Value |
|---|---|
| Position | Left |
| Auto-hide | On, no delay |
| Icon size | 34, magnify on hover |
| Recent apps | Hidden |
| Pinned apps (in order, via `dockutil`) | Chrome, Slack, Messages, Claude, Ghostty, Notes, Reminders, Photos, 1Password, Spotify, Serato DJ Pro, iPhone Mirroring, System Settings. Apps that aren't installed are skipped. |

## Finder

| Setting | Value |
|---|---|
| Default view | Columns, folders first |
| File extensions | Always shown |
| Path bar, status bar | Shown |
| Search | Current folder |
| Warning when changing an extension | On |
| `.DS_Store` on network drives | Not created |

## Appearance, screenshots, sound

| Setting | Value |
|---|---|
| Appearance | Light mode (no automatic switching) |
| Hot corners | None |
| Screenshots | Saved to the Desktop |
| Volume change | Plays the feedback sound |
| Startup chime | On (macOS default). Not scripted: changing it needs admin (`sudo nvram StartupMute=...`). |

## Keyboard shortcuts

| Shortcut | Does |
|---|---|
| `Cmd+Space` | Alfred (set in Alfred) |
| `Option+Space` | Spotlight |
| `Cmd+Option+Space` | Finder search window |
| `Ctrl+←` / `Ctrl+→` | Previous / next desktop |
| `Ctrl+1`…`Ctrl+9` | Go to desktop 1–9 (only if that desktop exists). Drag a window while pressing one to move it there. |

## Alfred

Settings sync through **iCloud Drive → Alfred** (`~/Library/Mobile Documents/com~apple~CloudDocs/Alfred`), not the repo: snippets and workflows can hold personal info. The script points Alfred 5 at it by writing `~/Library/Application Support/Alfred/prefs.json` (Alfred 5 ignores the old `syncfolder` default). The previous Dropbox copy is kept as a backup.

On a new Mac, wait for iCloud Drive to download the Alfred folder, then run `chezmoi apply` again if Alfred didn't pick it up.
