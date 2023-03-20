{ config
, pkgs
, lib
, username
, ...
}:
{
  home.packages = with pkgs; [
  
    deno
    verilog

    # video Edit
    mediainfo
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  
  programs.git = {
    userName = "Adam Parak";
    userEmail = "xparak1@fi.muni.cz";
  };
}
