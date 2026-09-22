{
  pkgs,
  hyprland-community,
  ...
}:
{
  wayland.windowManager.hyprland = {
    plugins = [
      hyprland-community.hypr-dynamic-cursors.packages.${pkgs.system}.default
    ];
  };
}
