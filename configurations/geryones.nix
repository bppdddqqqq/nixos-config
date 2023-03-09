# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
{
  hardware.opengl = {
    enable = true;
  };

  networking = {
    hostName = "geryones"; # Define your hostname.
  };

  environment.systemPackages = with pkgs; [
    gnumake
    gcc
    pciutils
    file
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  services.xserver.wacom.enable = true;
  services.xserver.xkbOptions = "eurosign:e";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.wireless.enable = false;

  imports = [./geryones-hw.nix];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
  users.extraGroups.vboxusers.members = ["lorax"];
}
