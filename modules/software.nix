{
  pkgs,
  config,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    nomacs
    
    # diagnostic tools
    nvme-cli
    smartmontools
    
    ncdu_2
    smartmontools
    lm_sensors
    
    unrar
    xarchiver
    p7zip
    zip
    appimage-run
    unzip
    tmux
    
    # code quality stuff for nix
    nixpkgs-fmt

    # python
    python3Full
    python310Packages.pip

    # tor
    tor-browser-bundle-bin

    # wine
    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # basic dev tools
    git
    tldr
    yq-go
  ];
}
