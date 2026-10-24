{ pkgs, tuicr-pkg, nub-pkg, ... }:

{
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

    tuicr-pkg
    # nub-pkg
  ];

  # NOTE: also run `chsh -s $(which zsh)` once to make it your login shell.
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
