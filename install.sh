#!/usr/bin/env bash
# Set up a Mac from scratch. Run in Terminal:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/timcheadle/dotfiles/master/install.sh)"
# Safe to run again; finished steps are skipped. Next steps: docs/setup.md
set -euo pipefail

REPO_URL="https://github.com/timcheadle/dotfiles.git"
DOTFILES="$HOME/src/dotfiles"

step() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }

if [[ "$(uname)" != Darwin ]]; then
  echo "This script is for macOS."
  exit 1
fi

step "Homebrew"
if [[ ! -x /opt/homebrew/bin/brew ]]; then
  echo "Installing Homebrew. It asks for your password (admin) to create /opt/homebrew"
  echo "and install Apple's developer tools."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Already installed."
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

step "chezmoi"
if ! command -v chezmoi >/dev/null; then
  brew install chezmoi
else
  echo "Already installed."
fi

step "Dotfiles repo at $DOTFILES"
if [[ ! -d "$DOTFILES/.git" ]]; then
  mkdir -p "$(dirname "$DOTFILES")"
  git clone "$REPO_URL" "$DOTFILES"
else
  echo "Already cloned."
fi
mkdir -p "$HOME/.local/share"
if [[ ! -e "$HOME/.local/share/chezmoi" ]]; then
  ln -s "$DOTFILES" "$HOME/.local/share/chezmoi"
fi

step "Apply: apps (brew bundle), configs, macOS settings"
# First run asks for your name and emails; they're stored locally, not in the repo.
chezmoi init --apply

cat <<'EOF'

Done. A few things can't be scripted; see docs/setup.md:
  1. 1Password: sign in, then Settings > Developer: turn on the SSH agent and CLI integration
  2. System Settings > Privacy & Security > App Management: allow Ghostty
  3. GitHub CLI: gh auth login
  4. Wait for iCloud Drive to sync the Alfred folder, then run: chezmoi apply
  5. Log out and back in so keyboard settings take effect
EOF
