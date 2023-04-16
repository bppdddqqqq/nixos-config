# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  networking = {
    hostName = "tron"; # Define your hostname.
  };

  services.xserver.videoDrivers = ["nvidia" "displaylink"];
  # zephyrus has a Nvidia GTX 1070
  # intel gpu
  hardware.opengl = {
    enable = true;
  };

  # for enabling prime :)
  # environment.systemPackages = [nvidia-offload];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    #    modesetting.enable = true;
    #    prime = {
    #      offload.enable = true;
    #
    #      intelBusId = "PCI:0:2:0";
    #
    #      nvidiaBusId = "PCI:1:0:0";
    #    };
  };

  environment.systemPackages = with pkgs; [
    cudatoolkit
    cudatoolkit.lib
    pciutils
    file
    vulkan-tools
    lutris
  ];

  systemd.services.nvidia-control-devices = {
    wantedBy = ["multi-user.target"];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  services.xserver.wacom.enable = true;
  services.xserver.xkbOptions = "eurosign:e";

  services.vaultwarden.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;

  # virtualbox
  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.x11 = true;
  #users.extraGroups.vboxusers.members = ["lorax"];

  imports = [./tron-hw.nix];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
}
