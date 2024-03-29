{
  outputs =
    { self
    , nixos-hardware
    , nixpkgs
    , nixos-generators
    , home-manager
    , nixvim
    , nur
    , nixpkgs-unstable
    , nix-vscode-extensions
    , ...
    } @ attrs:
    let
      username = "lorax";
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      nixosConfigurations.amnesix = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = attrs // {
          inherit system;
          inherit username;
        };
        modules = [
          ./presets/server.nix
          ./configurations/amnesix.nix

          ./modules/cpp.nix
          ./modules/docker.nix
        ];
      };
      nixosConfigurations.geryones = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = attrs // {
          inherit system;
          inherit username;
        };
        modules = [
          ./presets/gui.nix
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
          ./presets/gui.nix
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
          ./presets/gui.nix
          ./configurations/dellrax.nix

          ./modules/cpp.nix
          ./modules/docker.nix
          nixos-hardware.nixosModules.dell-xps-13-9370
        ];
      };
    };

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.nixlib.url = "github:nix-community/nixpkgs.lib";

  inputs.precommit = {
    url = "github:cachix/pre-commit-hooks.nix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.nixpkgs-stable.follows = "nixpkgs";
    inputs.flake-compat.follows = "flake-compat";
    inputs.flake-utils.follows = "flake-utils";
  };
  inputs.poetry2nix = {
    url = "github:nix-community/poetry2nix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };
  inputs.beautysh = {
    url = "github:lovesegfault/beautysh";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.utils.follows = "flake-utils";
    inputs.poetry2nix.follows = "poetry2nix";
  };
  inputs.nur.url = github:nix-community/NUR;
  inputs.nixvim = {
    url = "github:pta2002/nixvim";
    inputs.nixpkgs.follows = "nixpkgs-unstable";
    inputs.beautysh.follows = "beautysh";
    inputs.flake-utils.follows = "flake-utils";
    inputs.pre-commit-hooks.follows = "precommit";
  };
  inputs = {
    firefox-gnome-theme = { url = "github:rafaelmardojai/firefox-gnome-theme"; flake = false; };
  };
  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-23.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nixos-generators = {
    url = "github:nix-community/nixos-generators";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.nixlib.follows = "nixlib";
  };
  inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions";
    inputs.flake-compat.follows = "flake-compat";
    inputs.flake-utils.follows = "flake-utils";
    inputs.nixpkgs.follows = "nixpkgs-unstable";
  };
}
