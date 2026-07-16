{
  lib,
  ...
}:

rec {
  imports = [
    ./gtk
    ./packages
    ./progs
  ] ++ (
    lib.lists.optional wayland.windowManager.hyprland.enable ./hyprland
  );

  services.udiskie.enable = true;
  services.mpris-proxy.enable = true;

  programs.home-manager.enable = true;

  wayland.windowManager.hyprland.enable = true;

  home.username = "admin";
  home.homeDirectory = "/home/admin";

  home.stateVersion = "26.05";
}
