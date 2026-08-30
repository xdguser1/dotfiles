{
  pkgs,
  hyprland-community,
  ...
}:
{
  imports = [
    ./hypr-dynamic-cursors.nix
  ];

  wayland.windowManager.hyprland = {
    plugins = [
      hyprland-community.hypr-dynamic-cursors.packages.${pkgs.system}.default
    ];
  };
}
