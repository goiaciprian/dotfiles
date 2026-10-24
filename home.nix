{ pkgs, tuicr-pkg, nub-pkg, ... }:

{
  # ── Packages ──────────────────────────────────────────────
  # home.username / home.homeDirectory are set dynamically in flake.nix
  home.packages = with pkgs; [
    glow
    eza
    stow
    ncdu
    neovim
    luarocks
    lefthook
    fzf
    ripgrep
    zoxide
    bat
    git
    gh
    gh-dash
    tmux
    oh-my-posh
    gcc
    zsh
    zinit
    # Third-party flake packages
    tuicr-pkg
    nub-pkg
  ];

  # ── Default Shell ─────────────────────────────────────────
  # Sets the SHELL env var for all HM-managed sessions.
  # NOTE: also run `chsh -s $(which zsh)` once to make it your login shell.
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  # ── State Version ─────────────────────────────────────────
  # Set once, never change. Tracks HM activation schema.
  home.stateVersion = "24.11";

  # ── Let HM manage itself ──────────────────────────────────
  programs.home-manager.enable = true;
}
