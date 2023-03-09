{
  outputs = {
    self,
    nixos-hardware,
    nixpkgs,
    nixos-generators,
    home-manager,
    ...
  } @ attrs: let
    username = "lorax";
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    nixosConfigurations.geryones = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = attrs // {
        inherit system;
        inherit username;
      };
      modules = [
        ./presets/basic.nix
        ./configurations/geryones.nix

        ./modules/cpp.nix
        ./modules/docker.nix
      ];
    };
    nixosConfigurations.tron = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = attrs // {
        inherit system;
        inherit username;
      };
      modules = [
        ./presets/basic.nix
        ./configurations/tron.nix

        ./modules/cpp.nix
        ./modules/docker.nix
        ./modules/printing.nix
        ./modules/steam.nix
      ];
    };
    nixosConfigurations.dellrax = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = attrs // {
        inherit system;
        inherit username;
      };
      modules = [
        ./presets/basic.nix
        ./configurations/dellrax.nix

        ./modules/cpp.nix
        ./modules/docker.nix
        nixos-hardware.nixosModules.dell-xps-13-9370
      ];
    };
  };
  inputs.neovim-flake.url = "github:jordanisaacs/neovim-flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.nixvim.url = github:pta2002/nixvim;
  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-22.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nixos-generators = {
    url = "github:nix-community/nixos-generators";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.vim-flake = {
    url = "path:software-flake/vim";
    flake = true;
  };
  inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions?rev=83b9f149ffc2a6cdd44d8083050e7e245706ae2f";
  };
}
