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
    ./dellrax-hw.nix
  ];

  networking = {
    hostName = "dellrax"; # Define your hostname.
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.extraModprobeConfig = ''

# compiles linux with crashdump kernel, enable if things appear sus
#  boot.crashDump.enable = true;

  boot.kernelParams = [
    "pcie.aspm=force"
    "intel_idle.max_cstate=1"
    "i915.enable_fbc=1"
    "i915.enable_rc6=7"
    "i915.lvds_downclock=1"
    "i915.enable_guc_loading=1"
    "i915.enable_guc_submission=1"
    "i915.enable_psr=0"
  ];

  # intel gpu
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  services.xserver.wacom.enable = true;
  virtualisation.lxc.enable = true;
  virtualisation.lxd.enable = true;

  services.pcscd.enable = true;
  services.pcscd.plugins = [ pkgs.acsccid ];

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
  powerManagement.cpuFreqGovernor = "powersave";
  powerManagement.powertop.enable = true;
  services.tlp.enable = true;
  services.tlp.settings = {
    USB_AUTOSUSPEND=0;
    RUNTIME_PM_BLACKLIST="06:00.3 06:00.4";
  };
  # services.tlp.settings = {
  #   CPU_SCALING_MIN_FREQ_ON_AC=800000;
  #   CPU_SCALING_MIN_FREQ_ON_BAT=600000;
  #   CPU_MIN_PERF_ON_AC=3;
  #   CPU_MIN_PERF_ON_BAT=3;
  # };
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

  # boot.kernelPackages = pkgs.linuxPackages.extend (self: super: {
  #   virtualbox = super.virtualbox.override {
  #     inherit (self) kernel;
  #   };
  #   virtualboxGuestAdditions = super.virtualboxGuestAdditions.override {
  #     inherit (self) kernel;
  #   };
  # });
  ## also, the user program override should be introduced 
  ## directly at packageOverrides
  # nixpkgs.config.packageOverrides = ps: {
  #   virtualbox = pkgs.unstable.virtualbox;
  #   virtualboxExtpack = pkgs.unstable.virtualboxExtpack;
  #   # linuxPackages = pkgs.unstable.linuxPackages;
  # };

  virtualisation.vmware.host.enable = true;

  # virtualisation.libvirtd.enable = true;
  # environment.systemPackages = with pkgs; [ virt-manager ];

  environment.variables = {
    MOZ_USE_XINPUT2 = "1";
    #GDK_SCALE = "2";
    #GDK_DPI_SCALE = "0.5";
    #_JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
