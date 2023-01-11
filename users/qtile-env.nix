{ username, home-manager-opts ? {}, pkgs, config, lib, ...}:
{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "audio" "plugdev" "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };
  
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; } )
  ];

  home-manager.users.${username} = lib.mkMerge [
    home-manager-opts 
    {
      nixpkgs.config = import ../nixpkgs-config.nix;
      home.stateVersion = "22.05";
      home.packages = with pkgs; [
          # desktop
          qtile
          kitty
          escrotum
          rofi
          betterlockscreen
          dunst
          libcanberra-gtk3
          brightnessctl
          dig
          
          # python39Full -- this causes a collission with qtile env, THIS SHOULD NEVER HAPPEN IN NORMAL CASES WTF
          python39Packages.psutil
      ];

      xsession.enable = true;
      # xsession.desktopManager.gnome.enable = false;
      xsession.windowManager.command = "${pkgs.qtile}/bin/qtile start";

      home.file.".config/" = { source = ./qtile/.config; recursive = true; };
      home.file.".local/" = { source = ./qtile/.local; recursive = true; };
      # home.file.".config/qtile/config.py".text = builtins.readFile ./config-qtile.py;
      home.file.".byobu/.tmux.conf".text = ''
        set -g default-shell ${pkgs.fish}/bin/fish
        set -g default-command ${pkgs.fish}/bin/fish
      '';

      programs = {
        fish.enable = true;
      };
    } 
  ];
}
