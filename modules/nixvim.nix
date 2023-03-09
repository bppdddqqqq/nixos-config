{
  config,
  pkgs,
  nixvim,
  ...
}: let
  config = {
    colorschemes.gruvbox.enable = true;
  };
  nvim = nixvim.makeNixvim config;
in {
  environment.systemPackages = [
    nvim
  ];
}
