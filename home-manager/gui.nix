{ config
, pkgs
, lib
, username
, firefox-gnome-theme
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
      BSDA
      exactci
      markdown
      ggpubr
      moonBook
      ggiraph
      ggiraphExtra
      plyr
      Rlab
      mime
      rmarkdown
      xfun
      yaml
      fBasics
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
    thunderbird
    calibre
    vlc
    libreoffice-qt
    discord
    anki
    kodi
    adl
    freecad
    rstudio
    pandoc
    google-fonts
    ffmpeg

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
    rawtherapee
    gmic
    gmic-qt
    digikam

    inkscape
    unstable.obsidian
    mplayer

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
    enableUpdateCheck = false;
    userSettings = {
      "[json]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };
      "explorer.confirmDragAndDrop" = false;
      "[css]" = {
        "editor.defaultFormatter" = "vscode.css-language-features";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
      "git.confirmSync" = false;
      "debug.onTaskErrors" = "showErrors";
      "[typescript]" = {
        "editor.defaultFormatter" = "vscode.typescript-language-features";
      };
      "emmet.triggerExpansionOnTab" = true;
      "redhat.telemetry.enabled" = false;
      "explorer.confirmDelete" = false;
      "window.zoomLevel" = -1;
      "window.titleBarStyle" = "custom";
      "window.commandCenter" = true;
      "window.autoDetectColorScheme" = true;
      "workbench.preferredDarkColorTheme" = "Adwaita Dark";
      "workbench.preferredLightColorTheme" = "Adwaita Light";
      "workbench.productIconTheme" = "adwaita";
      "editor.renderLineHighlight" = "none";
      "workbench.iconTheme" = null;
      "workbench.tree.indent" = 12;
    };
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
    ] ++ [
      unstable.vscode-extensions.matklad.rust-analyzer
    ] ++ [ pkgs.open-vsx.piousdeer.adwaita-theme ];

  };

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #gtk stuff
  gtk.enable = true; #todo: move to global?
  gtk.iconTheme.package = pkgs.gnome.adwaita-icon-theme;
  gtk.iconTheme.name = "Adwaita";
  gtk.theme.package = pkgs.gnome.gnome-themes-extra;
  gtk.theme.name = "Adwaita";
  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style.package = pkgs.adwaita-qt;
  qt.style.name = "adwaita";
  services.dunst.iconTheme.package = pkgs.gnome.adwaita-icon-theme;
  services.dunst.iconTheme.name = "Adwaita";

  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox.override {
    # See nixpkgs' firefox/wrapper.nix to check which options you can use
    cfg = {
      # Gnome shell native connector
      enableGnomeExtensions = true;
      # Tridactyl native connector
      enableTridactylNative = true;
    };
  };

  xdg.desktopEntries = {
    firefox-global = {
      name = "Firefox (Global)";
      genericName = "Web Browser";
      exec = "firefox -P \"Default\"";
      icon = "firefox";
      comment = "Launch Firefox Global profile";
      mimeType = [ ];
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
    firefox-old = {
      name = "Firefox (Old)";
      genericName = "Web Browser";
      exec = "firefox -P \"Old\"";
      icon = "firefox";
      comment = "Launch Firefox Old profile";
      mimeType = [ ];
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
  };

  home.file.".mozilla/firefox/global/chrome/firefox-gnome-theme".source = firefox-gnome-theme;
  programs.firefox.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    privacy-badger
    i-dont-care-about-cookies
    react-devtools
    facebook-container
    reduxdevtools
    vue-js-devtools
    angular-devtools
    unpaywall
    decentraleyes
    enhancer-for-youtube
    sponsorblock
    youchoose-ai
    flagfox
    forget_me_not
    ghostery
    leechblock-ng
    link-cleaner
    link-gopher
    no-pdf-download
    offline-qr-code-generator
    private-relay
  ];
  programs.firefox.profiles.old = {
    name = "Old";
    id = 1;
    path = "old.default";
  };
  programs.firefox.profiles.global = {
    settings = {
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable customChrome.cs
      "browser.uidensity" = 0; # Set UI density to normal
      "svg.context-properties.content.enabled" = true; # Enable SVG context-propertes
      "browser.theme.dark-private-windows" = false; # Disable private window dark theme
    };
    userChrome = ''
      @import "firefox-gnome-theme/userChrome.css";
    '';
    userContent = ''
      @import "firefox-gnome-theme/userContent.css";
    '';
    name = "Default";
    isDefault = true;
    bookmarks = [
      {
        name = "wikipedia";
        keyword = "wiki";
        url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
      }
      {
        name = "kernel.org";
        url = "https://www.kernel.org";
      }
      {
        name = "Nix sites";
        toolbar = true;
        bookmarks = [
          {
            name = "homepage";
            url = "https://nixos.org/";
          }
          {
            name = "wiki";
            url = "https://nixos.wiki/";
          }
        ];
      }
    ];
    search.default = "Google";
    search.engines = {
      "Nix Packages" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "type"; value = "packages"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "NixOS Wiki" = {
        urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@nw" ];
      };

      "Bing".metaData.hidden = true;
      "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
    };
  };
}
