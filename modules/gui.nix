{
  pkgs,
  config,
  ...
}: {
  #x11
  services.xserver = {
    enable = true;
    desktopManager = {
      gnome.enable = true;
      xterm.enable = false;
    };
    displayManager.gdm.enable = true;
    layout = "us";
    xkbVariant = "";

    libinput.enable = true;
  };
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ gnome.adwaita-icon-theme gnomeExtensions.appindicator gnome.gnome-settings-daemon ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  environment.gnome.excludePackages = (with pkgs; [
  #  gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
  #  gnome-terminal
    gedit # text editor
  #  epiphany # web browser
    geary # email reader
  #  evince # document viewer
    gnome-characters
    totem # video player
  #  tali # poker game
  #  iagno # go game
  #  hitori # sudoku game
  #  atomix # puzzle game
  ]);

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   pulse.enable = true;
  #   # If you want to use JACK applications, uncomment this
  #   #jack.enable = true;

  #   # use the example session manager (no others are packaged yet so this is enabled by default,
  #   # no need to redefine it in your config for now)
  #   #media-session.enable = true;
  # };
}
