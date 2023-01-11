{ config, pkgs, vim-flake, ... }: {
  nixpkgs.overlays = [ vim-flake.overlays."vflake/vim-flaked" ];

  environment.systemPackages = with pkgs; [ vim-flaked ];
}
