{
  config,
  pkgs,
  lib,
  username,
  ...
}: let
  vim-plugins = import ./vim-plugins.nix {inherit pkgs lib;};
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    firefox
    thunderbird
    xournalpp
    calibre
    vlc
    libreoffice-qt
    anki
    popcorntime
    kodi
    adl
    freecad
    rstudio

    darktable
    gimp
    unstable.obsidian

    # social
    tdesktop
    signal-desktop

    # LaTeX
    texstudio
    texlive.combined.scheme-full

    # video Edit
    unstable.libsForQt5.kdenlive

    unstable.nodePackages.pyright
    unstable.tree-sitter
    unstable.code-minimap
    luaPackages.lua-lsp
    rnix-lsp
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodePackages.bash-language-server
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
  ];

  programs.git = {
    userName = "Adam Parak";
    userEmail = "xparak1@fi.muni.cz";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs;
    with vimPlugins; [
      csv-vim
      vim-surround # fix config
      vim-repeat
      # vim-speeddating  # makes statusline buggy??
      vim-commentary
      vim-unimpaired
      vim-sleuth # adjusts shiftwidth and expandtab based on the current file
      vim-startify
      vim-multiple-cursors
      gundo-vim
      vim-easy-align
      vim-table-mode
      editorconfig-vim
      vim-markdown
      ansible-vim
      vim-nix
      robotframework-vim
      # vimspector
      vim-plugins.vim-bepoptimist
      vim-plugins.nvim-base16 # the one packaged in nixpkgs is different
      popup-nvim
      plenary-nvim
      telescope-nvim
      telescope-symbols-nvim
      # telescope-media-files  # doesn't support wayland yet
      nvim-colorizer-lua
      unstable.vimPlugins.nvim-treesitter.withAllGrammars
      nvim-lspconfig
      unstable.vimPlugins.lsp_extensions-nvim
      # completion-nvim
      # cmp-nvim-lsp
      nvim-cmp
      lspkind-nvim
      gitsigns-nvim
      neogit
      diffview-nvim
      unstable.vimPlugins.bufferline-nvim
      nvim-autopairs
      unstable.vimPlugins.galaxyline-nvim
      vim-closetag
      friendly-snippets
      vim-vsnip
      nvim-tree-lua
      nvim-web-devicons
      vim-devicons
      # vim-auto-save  # ?
      vim-plugins.neoscroll-nvim
      vim-plugins.zenmode-nvim
      minimap-vim
      vim-plugins.indent-blankline-nvim # using my own derivation because the nixpkgs still uses the master branch
      vim-easymotion
      quick-scope
      matchit-zip
      targets-vim
      neoformat
      vim-numbertoggle
      # vim-markdown-composer
      vimwiki
      pkgs.vimwiki-markdown
      vim-python-pep8-indent
      lsp_signature-nvim
      rust-tools-nvim
      vim-plugins.keymap-layer-nvim
      vim-plugins.hydra-nvim
    ];

    extraConfig = "lua << EOF\n" + builtins.readFile ./init.lua + "\nEOF";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
