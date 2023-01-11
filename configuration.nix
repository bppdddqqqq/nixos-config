# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, nixpkgs-unstable, home-manager, vim-flake, ... }:
let

  system = "x86_64-linux";
  nixpkgs-unstable-unfree = final: prev: { unstable = import nixpkgs-unstable { inherit system; config = { allowUnfree = true; }; }; };
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    hostName = "loranix"; # Define your hostname.
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:ve-*" ];
      dns = "none";
    };  
    enableIPv6 = false;
    extraHosts = ''
      104.16.22.35 registry.yarnpkg.com
    '';
  };
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
 
  time.timeZone = "Europe/Prague";

  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;
  
  nixpkgs.config = import ./nixpkgs-config.nix;
  #nixpkgs.unstable.config = import ./nixpkgs-config.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.overlays = [ vim-flake.overlays."vflake/vim-flaked" nixpkgs-unstable-unfree ];

  nix.settings.auto-optimise-store = true;
  services.udev.packages = [ pkgs.usb-blaster-udev-rules ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "lorax" ];

  imports =
    [
      home-manager.nixosModule
      ./hw/zephyrus.nix
      ./essentials/graphics.nix
      ./essentials/desktop.nix
      ./users/lorax.nix
#      ./users/quartus-user.nix
      ./software/software.nix
#      ./software/steam.nix
    ];

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ALL = "en_US.UTF-8";    
    LANGUAGE = "en_US.UTF-8";    
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.cnijfilter2 ];
  };

  users.users.root = {
    extraGroups = [ "networkmanager" ];
  };

  system.stateVersion = "22.11";
}

