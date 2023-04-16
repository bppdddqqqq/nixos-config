{ config
, pkgs
, nixvim
, system
, ...
}:
let
  config = {
    colorschemes.gruvbox.enable = true;
    globals.mapleader = ","; # Sets the leader key to comma
    maps.normal = {
      ";" = ":";
      "<leader>gg" = {
        silent = true;
        remap = false;
        action = "<cmd>Man<CR>";
        # Etc...
      };
    };
    plugins = {
      lsp = {
        servers = {
          clangd.enable = true;
          eslint.enable = true;
          # denols.enable = true;
          html.enable = true;
          jsonls.enable = true;
          pylsp = {
            enable = true;
            autostart = true;

            settings.plugins = {
              jedi_completion.enabled = true;
              jedi_completion.fuzzy = true;
              pylsp_mypy.enabled = true;
              flake8.enabled = true;
            };
          };
          rnix-lsp.enable = true;
          tailwindcss.enable = true;
          tsserver.enable = true;
          vuels.enable = true;
        };
      };
      luasnip = {
        enable = true;
      };
      telescope = {
        enable = true;
        extensions = {
            frecency.enable = true;
            fzf-native.enable = true;
        };
      };
      nvim-cmp.enable = true;
      nvim-cmp.mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          modes = [ "i" "s" ];
          action = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expandable() then
                luasnip.expand()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif check_backspace() then
                fallback()
              else
                fallback()
              end
            end
          '';
        };
      };
      nvim-cmp.snippet.expand = {
        __raw = ''
          function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end
        '';
      };
      nvim-cmp.sources = [
        { name = "nvim_lsp"; }
        { name = "nvim_lua"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
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
