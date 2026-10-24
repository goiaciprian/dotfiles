#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Source Nix environment (needed after fresh daemon install) ─
if [ -f /etc/profile.d/nix.sh ]; then
  # shellcheck disable=SC1091
  source /etc/profile.d/nix.sh
fi

# ── Dotfiles (stow) ───────────────────────────────────────────
stow . --dotfiles

# ── Home Manager ──────────────────────────────────────────────
# Use `nix run` to bootstrap — no need to pre-install home-manager.
# After the first switch, `home-manager` is managed by HM itself
# (programs.home-manager.enable = true) and lives in ~/.nix-profile/bin.
nix run home-manager/master -- switch --impure --flake "$DOTFILES_DIR"

# ── Default Shell (one-time) ──────────────────────────────────
# Source the HM session vars so $PATH includes ~/.nix-profile/bin
if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  # shellcheck disable=SC1091
  source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi

ZSH_PATH="$(which zsh 2>/dev/null || echo "")"
if [ -n "$ZSH_PATH" ] && [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "Setting default shell to $ZSH_PATH (may require password)..."
  grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells
  chsh -s "$ZSH_PATH"
fi

echo ""
echo "✓ Done! Run the following to activate your session:"
echo "  source ~/.nix-profile/etc/profile.d/hm-session-vars.sh"
echo "  exec zsh"
