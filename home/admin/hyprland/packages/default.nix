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
    hyprpicker
    overskride
    superfile
    wireplumber
  ];
}
