{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    bash-language-server
    jdt-language-server
    markdown-oxide
    rust-analyzer
    tinymist
  ];
}
