{ config
, pkgs
, nixvim
, system
, ...
}:
let
  config = {
    colorschemes.gruvbox.enable = true;
    plugins = {
      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          eslint.enable = true;
          denols.enable = true;
          html.enable = true;
          jsonls.enable = true;
          pylsp.enable = true;
          rnix-lsp.enable = true;
          tailwindcss.enable = true;
          tsserver.enable = true;
          vuels.enable = true;
        };
      };
      telescope = {
        enable = true;
        extensions = {
            frecency.enable = true;
            fzf-native.enable = true;
        };
      };
    };
  };
  nixvim' = nixvim.legacyPackages.${system};
  nvim = nixvim'.makeNixvim config;
in
{
  environment.systemPackages = [
    nvim
  ];
}
