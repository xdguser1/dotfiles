{
  pkgs,
  ...
}:

{
  imports = [
    ./hypridle
    ./hyprlock
    ./hyprpaper
    ./packages
    ./plugins
  ];

  wayland.windowManager.hyprland = {
    enable        = true;
    package       = null;
    portalPackage = null;
    configType    = "lua";

    xwayland.enable = true;

    extraConfig = builtins.readFile ./main.lua;
  };
}
