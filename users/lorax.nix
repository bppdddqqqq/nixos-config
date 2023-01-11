{ config, pkgs, ... }:
{
  users.users.lorax = {
    isNormalUser = true;
    extraGroups = [ "audio" "plugdev" "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };
  
  home-manager.users.lorax = {
    nixpkgs.config = import ../nixpkgs-config.nix;
    home.stateVersion = "22.05";
    home.packages = with pkgs; [
      airshipper
      unstable.prismlauncher

      firefox
      torrential
      unstable.darktable
      inkscape
      krita
      qmapshack
      thunderbird

      dotnet-sdk_7
    ];

    # Do not forget to set 777 on ~/.config/pulse
    # Note: not safe, improve safety using uGroups

    xdg.mimeApps.defaultApplications = {
       "text/html" = "firefox.desktop";
       "x-scheme-handler/http" = "firefox.desktop";
       "x-scheme-handler/https" = "firefox.desktop";
       "x-scheme-handler/about" = "firefox.desktop";
       "x-scheme-handler/unknown" = "firefox.desktop";
    };

    home.file.".byobu/.tmux.conf".text = ''
      set -g default-shell ${pkgs.fish}/bin/fish
      set -g default-command ${pkgs.fish}/bin/fish
    '';
    home.file.".Xresources".text = ''
      xterm*background: black
      xterm*foreground: lightgray
    '';

    programs = {
      fish.enable = true;

      vscode.enable = true;
      vscode = {
        extensions = with pkgs.vscode-extensions; [
          arrterian.nix-env-selector
          jnoortheen.nix-ide
          octref.vetur
          ms-python.python
          ms-python.vscode-pylance
          ms-dotnettools.csharp
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "ionic";
            publisher = "Ionic";
            version = "1.8.12";
            sha256 = "17vx1664ni20alvwb1w7yjy3811diqw83h1la7ylzv9cjsdnxljs";
          }
        ];
      };

      git = {
        enable = true;
        userName = "48";
        userEmail = "definitelynotmymail@gmail.com";
      };

      chromium = {
        enable = true;
      };
    };    
  };
}
