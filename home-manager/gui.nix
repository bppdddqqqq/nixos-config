{ config
, pkgs
, lib
, username
, ...
}@attrs:
let
  rstudio = with pkgs; rstudioWrapper.override {
    packages = with rPackages; [
      ggplot2
      dplyr
      xts
      jpeg
      corrplot
      ggfortify
      base64enc
      evaluate
      highr
      htmltools
      jsonlite
      knitr
      markdown
      mime
      rmarkdown
      xfun
      yaml
    ];
  };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    firefox
    thunderbird
    xournalpp
    calibre
    vlc
    libreoffice-qt
    discord
    betterdiscordctl
    anki
    popcorntime
    kodi
    adl
    freecad
    rstudio
    pandoc
    hashcat
    hashcat-utils
    google-fonts

    zeal
    postman

    # linux iso download tools
    deluge
    frostwire-bin
    yt-dlp

    # verilog shenanigans
    gtkwave
    verilog

    # shenanigans
    the-powder-toy

    # editors
    darktable
    gimp
    inkscape
    unstable.obsidian

    # texstudio
    texstudio

    # LaTeX
    texlive.combined.scheme-full

    # social
    tdesktop
    signal-desktop

    # video Edit
    unstable.libsForQt5.kdenlive
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscodium;
    extensions = with pkgs; with vscode-marketplace; [
      serayuzgur.crates
      bungcip.better-toml
      ms-python.python
      rubymaniac.vscode-direnv
      denoland.vscode-deno
      angular.ng-template
      johnpapa.angular2
      bradlc.vscode-tailwindcss
      xabikos.javascriptsnippets
      xabikos.reactsnippets
      adpyke.codesnap
      formulahendry.auto-rename-tag
      christian-kohler.path-intellisense
      christian-kohler.npm-intellisense
      dsznajder.es7-react-js-snippets
      planbcoding.vscode-react-refactor
      esbenp.prettier-vscode
      # arrterian.nix-env-selector
      wix.vscode-import-cost
      burkeholland.simple-react-snippets
      stylelint.vscode-stylelint
      markusfalk.typescript-development-extension-pack
      rbbit.typescript-hero
      stringham.move-ts
      golang.go
      bbenoist.nix
      pinage404.nix-extension-pack
      jnoortheen.nix-ide
      gregorbiswanger.json2ts
      mshr-h.veriloghdl
      leafvmaple.verilog
      gtylcara-gewinn.verilog
      vscode-extensions.ms-vscode.cpptools
      eamodio.gitlens
      #     ms-vscode.cpptools-extension-pack
      austin.code-gnu-global
    ] ++ [ unstable.vscode-extensions.matklad.rust-analyzer ];
  };

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #gtk stuff
  gtk.iconTheme.package = pkgs.gnome.adwaita-icon-theme;
  gtk.iconTheme.name = "Adwaita";
}
