#!/usr/bin/env bash
set -euo pipefail

REPO="${HOME}/dotfiles"
cd "$REPO"

# Ensure directory skeleton
mkdir -p "${HOME}/bin" "${HOME}/.config"

# Symlink deploy
stow -vt "${HOME}" .config
stow -vt "${HOME}" bin
stow -vt "${HOME}" .zshrc
stow -vt "${HOME}" .gitconfig

# Permissions: make all bin files executable
find "${REPO}/bin" -type f -print0 | xargs -0 chmod +x

# Optional: zsh history hygiene (avoid future corruption)
touch "${HOME}/.zsh_history"
chmod 600 "${HOME}/.zsh_history"

echo "[bootstrap] Done."

