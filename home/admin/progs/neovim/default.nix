{
  pkgs,
  ...
}:

{
  imports = [
    ./lsp.nix
  ];

  home.packages = [ pkgs.lua52Packages.tree-sitter-cli ];

  programs.neovim = {
    enable        = true;
    defaultEditor = true;

    viAlias  = true;
    vimAlias = true;

    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      ccc-nvim
      cmp-buffer
      cmp-cmdline
      cmp-dotenv
      cmp-nvim-lua
      cmp-path
      cmp-treesitter
      diffview-nvim
      gitsigns-nvim
      highlight-undo-nvim
      hop-nvim
      lualine-nvim
      marks-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-tree-lua
      nvim-web-devicons
      range-highlight-nvim
      nvim-surround
      tabby-nvim
      telescope-nvim
      tokyonight-nvim
      trouble-nvim
      typst-vim
      undotree
      vim-easy-align
      vim-fugitive
      vim-illuminate
      vim-matchup
      vim-repeat
      zoxide-vim
    ];

    initLua = builtins.readFile ./init.lua;
  };
}
