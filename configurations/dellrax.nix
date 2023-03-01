# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}:
let
  fanConfig = builtins.readFile ./dellrax.fan;
in
{
  imports = [
    # Include the results of the hardware scan.
    ../hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.crashDump.enable = true;

  # intel gpu
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
#      vaapiVdpau
#      libvdpau-va-gl
    ];
  };
  services.xserver.wacom.enable = true;
  virtualisation.lxc.enable = true;
  virtualisation.lxd.enable = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  #x11
  services.xserver = {
    # dell 4K specific scaling that works(TM)
    dpi = 180;
  };

  # power mgmt
  powerManagement.enable = true;
  #powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.powertop.enable = true;
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_MIN_FREQ_ON_AC=800000;
    CPU_SCALING_MIN_FREQ_ON_BAT=600000;
    CPU_MIN_PERF_ON_AC=3;
    CPU_MIN_PERF_ON_BAT=3;
  };
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

  # services
  services.acpid.enable = true;
  services.fwupd.enable = true;
  services.vnstat.enable = true;

  #  specialisation = {
  #    battery-mode.configuration = {
  #      system.nixos.tags = ["battery-mode"];
  #      services.xserver = {
  #        displayManager.defaultSession = "xfce";
  #      };
  #    };
  #    default-mode.configuration = {
  #      system.nixos.tags = ["default-mode"];
  #      services.xserver = {
  #        displayManager.defaultSession = "plasma";
  #      };
  #    };
  #  };

  # virtualbox
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
  users.extraGroups.vboxusers.members = ["lorax"];
  virtualisation.docker.enable = true;

  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
    #GDK_SCALE = "2";
    #GDK_DPI_SCALE = "0.5";
    #_JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
