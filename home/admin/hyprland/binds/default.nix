{
  ...
}:

{
  imports = [
    ./bind.nix
    ./bindc.nix
    ./binde.nix
    ./bindl.nix
    ./bindm.nix
    ./bindel.nix
  ];

  wayland.windowManager.hyprland = {
    settings.config.binds.drag_threshold = 10;
  };
}
