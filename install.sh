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
# First run asks work or personal, your name and email; they're stored locally, not in the repo.
run_start="$(mktemp)"
# Ask work or personal here, so it takes the whole word (chezmoi's prompt answers on one letter).
init_args=()
machine="$(chezmoi execute-template '{{ .machine }}' 2>/dev/null || true)"
if [[ "$machine" != work && "$machine" != personal ]]; then
  while true; do
    read -r -p "Is this your work or personal Mac? (type work or personal): " machine
    [[ "$machine" == work || "$machine" == personal ]] && break
    echo "Please type the whole word: work or personal."
  done
  init_args=(--promptChoice "Is this your work or personal Mac=$machine")
fi
chezmoi init --apply ${init_args[@]+"${init_args[@]}"}

# Only list the manual steps that still need doing.
todo=()
machine="$(chezmoi execute-template '{{ .machine }}' 2>/dev/null || true)"
if [[ ! -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]]; then
  todo+=("1Password: sign in, then Settings > Developer: turn on 'Use the SSH agent'")
fi
if ! op account list 2>/dev/null | grep -q .; then
  todo+=("1Password: Settings > Developer: turn on 'Integrate with 1Password CLI'")
fi
if [[ "$machine" == work ]]; then
  glab auth status >/dev/null 2>&1 || todo+=("GitLab CLI: glab auth login")
else
  gh auth status >/dev/null 2>&1 || todo+=("GitHub CLI: gh auth login")
fi
if [[ "$machine" == work ]]; then
  # The Alfred script sets Cmd+Space once Alfred has made its settings folder.
  if ! grep -qs "<integer>1048576</integer>" "$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/preferences/local"/*/hotkey/prefs.plist; then
    todo+=("Alfred: open it once, then run: dotfiles-update (sets Cmd+Space)")
  fi
elif ! grep -q "com~apple~CloudDocs/Alfred" "$HOME/Library/Application Support/Alfred/prefs.json" 2>/dev/null; then
  todo+=("Alfred: wait for iCloud Drive to download the Alfred folder, then run: chezmoi apply")
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

If macOS asks about App Management, allow Ghostty (so brew can update apps).
Setup guide: ~/src/dotfiles/docs/setup.md
  https://github.com/timcheadle/dotfiles/blob/main/docs/setup.md
EOF
