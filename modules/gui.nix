{ pkgs
, config
, ...
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
  environment.systemPackages = with pkgs; [ gnome.adwaita-icon-theme gnomeExtensions.appindicator gnome.gnome-settings-daemon chromium ];
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  programs.chromium = {
    enable = true;
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-US"
      ];
    };
    extensions = [
      "chlffgpmiacpedhhbkiomidkjlcfhogd" # pushbullet
      "mbniclmhobmnbdlbpiphghaielnnpgdp" # lightshot
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere▾▾▾
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "fmkadmapgofadopljbjfkapdkoienihi" # react devtools
      "oddhnidmicpefilikhgeagedibnefkcf" # react context devtool
      "ldpochfccmkkmhdbclfhpagapcfdljkj" # decentraleyes
      "lhdoppojpmngadmnindnejefpokejbdd" # axe devtools
      "lmhkpmbekcpmknklioeibfkpmmfibljd" # redux devtools
      "hbdkkfheckcdppiaiabobmennhijkknn" # openseo
    ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
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
