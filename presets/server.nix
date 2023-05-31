{ config, pkgs, lib, home-manager, username, ... }@attrs:
{

  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [
    bashmount
  ];
  services.xserver = {
    autorun = false;
    layout = "us";
    enable = true;
    desktopManager.xterm.enable = false;
    displayManager.lightdm.enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };


  imports = [
    ../modules/dnscrypt.nix
    ../modules/globals.nix
    ../modules/locale.nix
    ../modules/nixvim.nix
    ../modules/software.nix
    ../modules/fail2ban.nix

    ../overlays/unstable.nix

    home-manager.nixosModules.home-manager
    {
      users.users."${username}" = {
        isNormalUser = true;
        extraGroups = [ "lxd" "docker" "networkmanager" "wheel" "editors" "libvirtd" ];
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} =
        { config
        , pkgs
        , lib
        , ...
        }:
        import ../home-manager/server.nix {
          inherit config;
          inherit pkgs;
          inherit lib;
          inherit username;
        };
    }
  ];
}
