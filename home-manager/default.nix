{
  config,
  pkgs,
  username,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    firefox
    thunderbird
    xournalpp
    calibre
    vlc
    libreoffice-qt
    anki
    popcorntime
    kodi
    adl
    freecad

    darktable
    gimp
    unstable.obsidian

    # social
    tdesktop
    signal-desktop

    # LaTeX
    texstudio
    texlive.combined.scheme-full

    # video Edit
    unstable.libsForQt5.kdenlive
  ];

  programs.git = {
    userName = "Adam Parak";
    userEmail = "xparak1@fi.muni.cz";
  };

  imports = [
    (import ../nix-nvim)
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
