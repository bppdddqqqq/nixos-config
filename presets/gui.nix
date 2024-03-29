{ config, lib, home-manager, username, nur, firefox-gnome-theme, ... }@attrs:
{
  imports = [
    ../modules/dnscrypt.nix
    ../modules/globals.nix
    ../modules/gui.nix
    ../modules/locale.nix
    ../modules/nixvim.nix
    ../modules/software.nix
    ../modules/software-gui.nix
    ../modules/xdg.nix

    ../overlays/vscode.nix
    ../overlays/unstable.nix
    ../overlays/nur.nix

    home-manager.nixosModules.home-manager
    {
      users.users."${username}" = {
        isNormalUser = true;
        extraGroups = [ "lxd" "docker" "networkmanager" "wheel" "editors" "libvirtd" "audio" ];
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
          inherit firefox-gnome-theme;
        };
    }
  ];
}
