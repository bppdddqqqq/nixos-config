# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
let
  stageshow = pkgs.stdenv.mkDerivation rec {
    name = "stageshow";
    version = "9.7.4";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/plugin/stageshow.zip";
      hash = "sha256-500rQRiFm+35/VrA+1nk2k2G0JJLZPe9xZtGt/PlM/o=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
  userRoleEditor = pkgs.stdenv.mkDerivation rec {
    name = "user-role-editor-wp";
    version = "4.63.3";
    src = pkgs.fetchzip {
      url = "https://downloads.wordpress.org/plugin/user-role-editor.4.63.3.zip";
      hash = "sha256-OSDpromanh/I/FtFviUpk4n+sNoLmhttPN/NadytWQ8=";
    };
    installPhase = "mkdir -p $out; cp -R * $out/";
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    # ./dellrax-hw.nix
  ];

  networking = {
    hostName = "wprax"; # Define your hostname.
  };


  wordpress
  services.wordpress.sites."localhost" = {
    plugins = [
      stageshow
      userRoleEditor
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  services.xserver.wacom.enable = true;
  virtualisation.lxc.enable = true;
  virtualisation.lxd.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];
}
