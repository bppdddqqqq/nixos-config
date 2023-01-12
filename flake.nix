{
  outputs = {
    self,
    nixos-hardware,
    nixpkgs,
    nixos-generators,
    neovim-flake,
    nixpkgs-unstable,
    ...
  } @ attrs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    nixosConfigurations.tron = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configurations/tron.nix

        ./overlays/unstable.nix

        ./flake-installs/neovim-flake.nix

        ./modules/globals.nix
        ./modules/dnscrypt.nix
        ./modules/gui.nix
        ./modules/printing.nix
        ./modules/steam.nix
        ./modules/locale.nix
        ./modules/software.nix
      ];
    };
    nixosConfigurations.dellrax = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configurations/dellrax.nix

        ./overlays/unstable.nix

        ./flake-installs/neovim-flake.nix

        ./modules/globals.nix
        ./modules/locale.nix
        ./modules/software.nix
        nixos-hardware.nixosModules.dell-xps-13-9370
      ];
    };
  };
  inputs.neovim-flake.url = "github:jordanisaacs/neovim-flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
}
