# Notes for AI agents

Read [`docs/decisions.md`](docs/decisions.md) before changing anything. It records what was chosen and why; don't undo those choices without asking.

## Working on this repo

- Ask one question at a time, in plain words, and wait for the answer. Don't change files or install things without a yes.
- Don't infer preferences from old config (the `archive` branch, Dropbox/Mackup files). Ask instead.
- Never commit names, emails, company names or secrets. Use chezmoi template data or local files (`~/.zshrc.local`, `~/.gitconfig.local`).
- When a choice is made, update `docs/decisions.md` (the why) and the topic doc in `docs/` (the what, as tables).
- Repo-only files (docs, README, AGENTS.md, Brewfile) must be listed in `.chezmoiignore`, or chezmoi will copy them into `~`.
