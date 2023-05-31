{ config, pkgs, ... }: {
  xdg = {
    mime = {
      enable = true;
      defaultApplications = {
        # codium
        "application/json" = "codium.desktop";
        "application/ld+json" = "codium.desktop";
        "application/javascript" = "codium.desktop";
        "inode/directory" = "codium.desktop";
        "text/plain" = "codium.desktop";
        "text/x-csrc" = "codium.desktop";
        "application/x-php" = "codium.desktop";
        "application/x-yaml" = "codium.desktop";

        # gnome defaults
        "image/*" = "org.nomacs.ImageLounge.desktop";
        "image/png" = "org.nomacs.ImageLounge.desktop";
        "image/jpeg" = "org.nomacs.ImageLounge.desktop";
        "image/tiff" = "org.nomacs.ImageLounge.desktop";
        "image/webp" = "org.nomacs.ImageLounge.desktop";
        "image/avif" = "org.nomacs.ImageLounge.desktop";
        "image/bmp" = "org.nomacs.ImageLounge.desktop";
        "image/gif" = "org.nomacs.ImageLounge.desktop";
        
        "video/*" = "vlc.desktop";
        "audio/*" = "mplayer.desktop";
        "application/pdf" = "org.gnome.Evince.desktop";

        # apps mumbojumbo
        "x-scheme-handler/tg" = "telegramdesktop.desktop";
        "x-scheme-handler/postman" = "Postman.desktop";

        # firefox
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/ftp" = "firefox.desktop";
        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
      };
    };
  };
}