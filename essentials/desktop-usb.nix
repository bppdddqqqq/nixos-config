{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "root";
  services.xserver.desktopManager.plasma5.enable = true;   

  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    nomacs
    google-fonts
  ];
}
