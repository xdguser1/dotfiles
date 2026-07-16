{
  pkgs,
  home-manager,
  ...
}:

{
  home.packages = with pkgs; [
    clipse
    exiftool
    hyprcursor
    hyperfine
    hyprland
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    hyprpolkitagent
    hyprland-qtutils
    hyprutils
    overskride
    superfile
    wireplumber
  ];
}
