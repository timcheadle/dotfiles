# SSH

Config: [`private_dot_ssh/config.tmpl`](../private_dot_ssh/config.tmpl).

## How it works

| Piece | What it does |
|---|---|
| 1Password SSH agent | Holds the keys and asks for Touch ID when one is used. Private keys never touch disk. |
| `~/.ssh/config` (from the repo) | Reads `config.local`, then points ssh at 1Password's agent (Mac only) |
| `~/.ssh/config.local` (this Mac only) | Server hosts and addresses. Never in the repo. |
| Old key files in `~/.ssh` | Still work; ssh tries them too |

## Keys

| Key | Where | Used for |
|---|---|---|
| GitHub SSH Key (ed25519) | 1Password, Private vault | GitHub login and commit signing |
| `id_rsa` and older project keys | `~/.ssh` files | Kept until it's clear where they're used; then import into 1Password or retire |

## Setup on a new Mac

1. In 1Password: **Settings → Developer**, turn on **Use the SSH agent** and **Integrate with 1Password CLI**.
2. `chezmoi apply` writes `~/.ssh/config`.
3. Copy or recreate `~/.ssh/config.local` for any servers you need.
4. Test: `ssh -T git@github.com` (approve the 1Password prompt).

## Adding a key to GitHub

```
gh auth refresh -h github.com -s admin:public_key,admin:ssh_signing_key   # once
op read "op://Private/GitHub SSH Key/public key" | gh ssh-key add - --title "..." --type authentication
```
