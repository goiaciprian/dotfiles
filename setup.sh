#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Dotfiles (stow) ───────────────────────────────────────
stow . --dotfiles

# ── Home Manager ──────────────────────────────────────────
# --impure is required so Nix can read $USER, $HOME, and
# builtins.currentSystem at evaluation time.
home-manager switch --impure --flake "$DOTFILES_DIR"

# ── Default Shell (one-time) ──────────────────────────────
ZSH_PATH="$(which zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "Setting default shell to $ZSH_PATH (requires password)..."
  # Ensure zsh is in /etc/shells
  grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells
  chsh -s "$ZSH_PATH"
fi
