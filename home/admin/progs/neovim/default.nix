{
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;

    viAlias  = true;
    vimAlias = true;

    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      ccc-nvim
      coc-clangd
      coc-css
      coc-diagnostic
      coc-docker
      coc-explorer
      coc-fzf
      coc-html
      coc-highlight
      coc-java
      coc-json
      coc-lists
      coc-lua
      coc-markdownlint
      coc-nvim
      coc-prettier
      coc-pyright
      coc-rust-analyzer
      coc-sh
      coc-texlab
      coc-toml
      coc-vimlsp
      coc-yaml
      diffview-nvim
      gitsigns-nvim
      highlight-undo-nvim
      hop-nvim
      lualine-nvim
      marks-nvim
      nvim-gdb
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      range-highlight-nvim
      nvim-surround
      tabby-nvim
      telescope-coc-nvim
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
    ] ++ (
      with pkgs; [
        nixd
      ]
    );

    coc = {
      enable   = true;
      settings = {
        "workspace.rootPatterns"            = [ ".git" ".hg" ".env" ];
        "explorer.icon.enableNerdfont"      = true;
        "explorer.previewAction.onHover"    = "labeling";
        "explorer.file.column.indent.chars" = "│ ";
        "explorer.file.child.template"      = "[git | 2] [selection | clip | 1] [indent][icon | 1] [diagnosticError & 1][filename omitCenter 1][modified] [readonly]";
        "signature.floatConfig.border"      = true;
        "signature.floatConfig.rounded"     = true;
        "hover.floatConfig.border"          = true;
        "hover.floatConfig.rounded"         = true;
        "diagnostic.floatConfig.border"     = true;
        "diagnostic.floatConfig.rounded"    = true;
        "diagnostic.enableMessage"          = "trigger";
      };
    };

    initLua = builtins.readFile ./init.lua;
  };
}
