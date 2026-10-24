{
  description = "Minimal setup for a new machine";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tuicr.url = "github:agavra/tuicr";
    nub.url = "github:nubjs/nub";
  };

  outputs = { self, nixpkgs, home-manager, tuicr, nub, ... }:
    # builtins.currentSystem and builtins.getEnv are impure — run with --impure
    let
      system   = builtins.currentSystem;
      username = builtins.getEnv "USER";
      homeDir  = builtins.getEnv "HOME";
      pkgs     = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.username    = username;
            home.homeDirectory = homeDir;
          }
          ./home.nix
        ];
        extraSpecialArgs = {
          tuicr-pkg = tuicr.packages.${system}.default;
          nub-pkg   = nub.packages.${system}.default;
        };
      };
    };
}
