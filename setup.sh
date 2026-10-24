#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Colours ───────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
info() { echo -e "${GREEN}[setup]${NC} $*"; }
warn() { echo -e "${YELLOW}[setup]${NC} $*"; }
die() {
  echo -e "${RED}[setup] ERROR:${NC} $*"
  exit 1
}

if id -nG "$USER" | grep -qw nix-users; then
  : # already a member, nothing to do
else
  warn "User '$USER' is not in nix-users. Adding now..."
  sudo usermod -aG nix-users "$USER"
  info "Re-running script under nix-users group (no logout needed)..."
  exec sg nix-users "$0" "$@"
fi

if [ -f /etc/profile.d/nix.sh ]; then
  source /etc/profile.d/nix.sh
fi
command -v nix &>/dev/null || die "nix not found. Install it first: https://nixos.org/download"

info "Enabling Nix flakes..."
mkdir -p ~/.config/nix
if ! grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null; then
  echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf
fi

info "Stowing dotfiles..."
command -v stow &>/dev/null || die "stow not found. Install it: sudo apt install stow"
stow --dir="$DOTFILES_DIR" --target="$HOME" --dotfiles \
  --ignore='.stowrc' --ignore='setup.sh' \
  --ignore='flake.nix' --ignore='flake.lock' \
  --ignore='lefthook.yml' --ignore='home.nix' \
  .

info "Running Home Manager switch (this may take a while on first run)..."
nix run home-manager/master -- switch --impure --flake "$DOTFILES_DIR"

HM_VARS="$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
if [ -f "$HM_VARS" ]; then
  source "$HM_VARS"
fi

ZSH_PATH="$(command -v zsh 2>/dev/null || true)"
if [ -z "$ZSH_PATH" ]; then
  warn "zsh not found in PATH after HM switch. Skipping chsh."
elif [ "$SHELL" != "$ZSH_PATH" ]; then
  info "Setting default shell to $ZSH_PATH..."
  grep -qxF "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" | sudo tee -a /etc/shells
  chsh -s "$ZSH_PATH"
fi

echo ""
info "✓ Setup complete!"
echo ""
echo "  To activate your session now, run:"
echo "    source ~/.nix-profile/etc/profile.d/hm-session-vars.sh"
echo "    exec zsh"
