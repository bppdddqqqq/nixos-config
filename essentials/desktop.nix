{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.wacom.enable = true;
  
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
   
  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "${pkgs.icewm}/bin/icewm";
  #networking.firewall.allowedTCPPorts = [ 3389 ];

  # Enable sound.
  
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };
  
  #musnix = {
  #  enable = true;
  #  alsaSeq.enable = true;

  #  soundcardPciId = "01:00.01";

  #  rtirq = {
  #    resetAll = 1;
  #    prioLow = 0;
  #    enable = true;
  #    nameList = "rtc0 snd";
  #  };
  #};

  # Enable openrazer
  # hardware.openrazer.enable = true;
  # hardware.openrazer.users = [ "lorax" ];

  #environment.gnome.excludePackages = (with pkgs; [
  #  gnome-tour
  #]) ++ (with pkgs.gnome; [
  #  pkgs.gnome-connections
  #  gnome-remote-desktop
  #  epiphany
  #  cheese
  #  gedit
  #  geary
  #  totem
  #  tali
  #  iagno
  #  hitori
  #  atomix
  #  gnome-contacts
  #]);
  
  services.usbmuxd.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol jack2Full jack_capture libjack2 jack2 qjackctl
  #  plasma-hud

  #  razergenie
    nomacs
    google-fonts
    icewm
    betterlockscreen

    libimobiledevice
    ifuse # optional, to mount using 'ifuse'

  ];
}
