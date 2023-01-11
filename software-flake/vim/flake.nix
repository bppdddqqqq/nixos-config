{
  outputs = inputs@{self, coc-nvim, nixpkgs, utils, ...} :
  let
    inherit (utils.lib) mkFlake exportOverlays;
    inherit (builtins) mapAttrs removeAttrs toFile;
    inherit (pkgs.lib) attrValues hasPrefix;
    pkgs = self.pkgs.x86_64-linux.nixpkgs;
    vimConfig = import ./settings.nix { inherit pkgs; suffix = ".vim"; };
    luaConfigsRaw = import ./settings.nix { inherit pkgs; suffix = ".lua"; };
    luaConfigs = toFile "init.lua" luaConfigsRaw;
    coc-settings = import ./coc-config.nix { inherit pkgs; };

  in mkFlake {
    inherit self inputs;
    channelsConfig.allowUnfree = true;
    supportedSystems = [ "x86_64-linux" ];

    channels.vflake.input = nixpkgs;
    channels.vflake.overlaysBuilder = channels: [
      (final: prev: {
        vim-flaked = let
          vimRegs = removeAttrs inputs [ "nixpkgs" "nixpkgs-unstable" "utils" "flake-compat" "self" ];
          vimPkgs = mapAttrs (name: pk: pkgs.vimUtils.buildVimPluginFrom2Nix ({
            inherit name;
            src = pk;
          } 
          )) vimRegs;
          start = attrValues vimPkgs ++ (with pkgs.vimPlugins; [
            coc-tsserver
            coc-pyright
            coc-tslint
            coc-tailwindcss
            coc-json
            coc-clangd
          ]);
        in
          prev.neovim.override {
            withNodeJs = true;
            withPython3 = true;
            viAlias = true;
            vimAlias = true;
            configure = {
              packages.plugins = {
                inherit start;
              };
              customRC = ''
                luafile ${luaConfigs}
                let g:coc_config_home = '${coc-settings}'
                ${vimConfig}
              '';
            };
        };
      })
    ];

    outputsBuilder = channels: rec {
        # construct packagesBuilder to export all packages defined in overlays
        packages = { inherit (channels.vflake) vim-flaked; };
        defaultPackage = packages.vim-flaked;
        devShell = channels.vflake.mkShell {
          name = "nixshell-vim";
          packages = [ defaultPackage ]; 
        };
    };
    overlays = exportOverlays {
      inherit (self) pkgs inputs;
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    telescope-nvim = {
      url = "github:nvim-telescope/telescope.nvim"; 
      flake = false;
    };
    telescope-filebrowser = {
      url = "github:nvim-telescope/telescope-file-browser.nvim";
      flake = false;
    };
    plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    coc-nvim = {
      url = "github:neoclide/coc.nvim/release";
      flake = false;
    };
    vim-nix = {
      url = "github:LnL7/vim-nix";
      flake = false;
    };
    telescope-coc-nvim = {
      url = "github:fannheyward/telescope-coc.nvim";
      flake = false;
    };
  };
}

