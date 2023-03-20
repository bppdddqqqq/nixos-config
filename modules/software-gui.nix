{
  pkgs,
  config,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nomacs
    
    # tor
    tor-browser-bundle-bin

    # wine
    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks
  ];
}
