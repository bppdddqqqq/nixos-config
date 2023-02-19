{
  pkgs,
  config,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    deluge
    xarchiver
    nomacs
    unrar
    libjxl
    ncdu_2
    frostwire-bin
    yt-dlp
    appimage-run
    tldr
    git
    zip
    unzip
    tmux
    zeal
    neovim

    # python
    python3Full
    python310Packages.pip

    tor-browser-bundle-bin

    # wine
    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # c development
    clang_14
    clang-tools_14
    lldb_14
    gcc
    cmake
    gnumake
    raylib
    valgrind
    musl
  ];
}
