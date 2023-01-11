{
  config,
  pkgs,
  neovim-flake,
  ...
}: {
  nixpkgs.overlays = [neovim-flake.overlays.default];

  environment.systemPackages = with pkgs; [neovim-maximal];
}
