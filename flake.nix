{
  description = "Minimal setup for a new machine";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    tuicr.url = "github:agavra/tuicr";
    nub.url = "github:nubjs/nub";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, tuicr, nub, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.buildEnv {
          name = "my-terminal-tools";
          paths = [
	    pkgs.eza
	    pkgs.stow
            pkgs.ncdu
            pkgs.neovim
            pkgs.lefthook
            pkgs.fzf
            pkgs.ripgrep
            pkgs.zoxide
            pkgs.bat
            pkgs.git
            pkgs.gh
            pkgs.gh-dash
            pkgs.tmux
            pkgs.oh-my-posh
            pkgs.zsh
            pkgs.sheldon
            tuicr.packages.${system}.default
            nub.packages.${system}.default
          ];

	  pathsToLink = [ "/bin" "/share" ];
        };
      }
    );
}
