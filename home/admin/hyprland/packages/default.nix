{
  pkgs,
  home-manager,
  ...
}:

{
  home.packages = with pkgs; [
    clipse
    exiftool
    hyperfine
    overskride
    superfile
    wireplumber
  ];
}
