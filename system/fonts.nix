{
  pkgs,
  ...
}:

{
  fonts.packages = with pkgs; [
    cantarell-fonts
    carlito
    fira
    fira-code
    fira-code-symbols
    ibm-plex
    jetbrains-mono
    liberation_ttf
    monoid
    nerd-fonts.blex-mono
    nerd-fonts.dejavu-sans-mono 
    nerd-fonts.inconsolata
    nerd-fonts.mononoki
    nerd-fonts.ubuntu
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    roboto
  ];
}
