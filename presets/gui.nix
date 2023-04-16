{ config, lib, home-manager, username, ... }@attrs:
{
  imports = [
    ../modules/dnscrypt.nix
    ../modules/globals.nix
    ../modules/gui.nix
    ../modules/locale.nix
    ../modules/nixvim.nix
    ../modules/software.nix
    ../modules/software-gui.nix

    ../overlays/vscode.nix
    ../overlays/unstable.nix

    home-manager.nixosModules.home-manager
    {
      users.users."${username}" = {
        isNormalUser = true;
        extraGroups = [ "lxd" "docker" "networkmanager" "wheel" "editors" "libvirtd"  ];
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} =
        { config
        , pkgs
        , lib
        , ...
        }:
        import ../home-manager/gui.nix {
          inherit config;
          inherit pkgs;
          inherit lib;
          inherit username;
        };
    }
  ];
}
