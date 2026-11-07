#!/usr/bin/env bash
# Set up a Mac from scratch. Run in Terminal:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/timcheadle/dotfiles/main/install.sh)"
# Safe to run again; finished steps are skipped. Next steps: ~/src/dotfiles/docs/setup.md
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
  echo "Already cloned; pulling the latest."
  git -C "$DOTFILES" pull --ff-only || echo "Couldn't pull (local changes?); using the repo as it is."
fi
mkdir -p "$HOME/.local/share"
if [[ ! -e "$HOME/.local/share/chezmoi" ]]; then
  ln -s "$DOTFILES" "$HOME/.local/share/chezmoi"
fi

step "Existing ~/.zshrc"
# Keep an existing zshrc as ~/.zshrc.local (loaded by the repo's .zshrc),
# so chezmoi can install its own without asking.
if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
  if [[ ! -e "$HOME/.zshrc.local" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.local"
    echo "Moved to ~/.zshrc.local. Trim anything that clashes (oh-my-zsh, prompt)."
  else
    mv "$HOME/.zshrc" "$HOME/.zshrc.pre-dotfiles"
    echo "~/.zshrc.local already exists; old file saved as ~/.zshrc.pre-dotfiles."
  fi
else
  echo "None to move."
fi

step "Apply: apps (brew bundle), configs, macOS settings"
# First run asks your name and git email; they're stored locally, not in the repo.
run_start="$(mktemp)"
chezmoi init --apply

# Only list the manual steps that still need doing.
todo=()
alfred_dir="$HOME/Library/Application Support/Alfred"
if ! grep -qs "com~apple~CloudDocs/Alfred" "$alfred_dir/prefs.json" \
  && ! grep -qs "<integer>1048576</integer>" "$alfred_dir/Alfred.alfredpreferences/preferences/local"/*/hotkey/prefs.plist; then
  todo+=("Alfred: open it once (or wait for iCloud Drive's Alfred folder), then run: dotfiles-update")
fi
if [[ "$HOME/.local/state/dotfiles/macos-applied" -nt "$run_start" ]]; then
  todo+=("Log out and back in so the new macOS settings take effect")
fi
rm -f "$run_start"

echo
if (( ${#todo[@]} == 0 )); then
  echo "All set."
else
  echo "Done. Still to do by hand:"
  for i in "${!todo[@]}"; do printf '  %d. %s\n' $((i + 1)) "${todo[$i]}"; done
fi
cat <<'EOF'

Sign-ins (1Password, gh/glab auth) and App Management: see the setup guide.
Setup guide: ~/src/dotfiles/docs/setup.md
  https://github.com/timcheadle/dotfiles/blob/main/docs/setup.md
EOF
