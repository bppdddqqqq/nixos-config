# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports = [
      ./amnesix-hw.nix
  ];

  environment.systemPackages = with pkgs; [
     unstable.papermc

     # admin
     byobu
     
     lynx
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "amnesix"; # Define your hostname
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 25565 8123 ];
    allowedUDPPorts = [ 25565 19132 ];
  };

  # Enable SSH server
  services.openssh = {
    enable = true;
    allowSFTP = true;
    passwordAuthentication = true;
  };

  # Enable web server
  services.nginx = { 
    enable = true;

    virtualHosts."jasanova.chickenkiller.com" = {
      forceSSL = false;
      onlySSL = false;
      rejectSSL = false;
      root = "/var/public_html/";
    };
  };
}
