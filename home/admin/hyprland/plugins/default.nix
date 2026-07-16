{
  pkgs,
  ...
}:

{
  imports = [
    ./hypr-dynamic-cursors.nix
  ];

  wayland.windowManager.hyprland = {
    plugins = [
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
    ];
  };
}
