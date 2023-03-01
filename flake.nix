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
    nixosConfigurations.geryones = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configurations/geryones.nix

        home-manager.nixosModules.home-manager
        {
          users.users."${username}" = {
            isNormalUser = true;
            extraGroups = ["lxd" "docker" "networkmanager" "wheel" "editors"];
          };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = {
            config,
            pkgs,
            lib,
            ...
          }:
            import ./home-manager {
              inherit config;
              inherit pkgs;
              inherit lib;
              inherit username;
            };
        }
        ./overlays/unstable.nix

        ./flake-installs/neovim-flake.nix

        ./modules/globals.nix
        ./modules/dnscrypt.nix
        ./modules/gui.nix
        ./modules/printing.nix
        ./modules/locale.nix
        ./modules/software.nix
      ];
    };
    nixosConfigurations.tron = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configurations/tron.nix

        home-manager.nixosModules.home-manager
        {
          users.users."${username}" = {
            isNormalUser = true;
            extraGroups = ["lxd" "docker" "networkmanager" "wheel" "editors"];
          };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = {
            config,
            pkgs,
            lib,
            ...
          }:
            import ./home-manager {
              inherit config;
              inherit pkgs;
              inherit lib;
              inherit username;
            };
        }
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
        home-manager.nixosModules.home-manager
        {
          users.users."${username}" = {
            isNormalUser = true;
            extraGroups = ["lxd" "docker" "networkmanager" "wheel" "editors"];
          };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = {
            config,
            pkgs,
            lib,
            ...
          }:
            import ./home-manager {
              inherit config;
              inherit pkgs;
              inherit lib;
              inherit username;
            };
        }
        ./configurations/dellrax.nix

        ./overlays/unstable.nix

        #./flake-installs/neovim-flake.nix

        ./modules/globals.nix
        ./modules/vscode.nix
        ./modules/gui.nix
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
  inputs.nix-vscode-extensions = {
    url = "github:nix-community/nix-vscode-extensions?rev=83b9f149ffc2a6cdd44d8083050e7e245706ae2f";
  };
}
