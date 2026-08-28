{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    firefox
    libreoffice-qt-stable
    texliveFull
  ];
}
