{
  pkgs,
  ...
}:

let
  fls   = import ../lib.nix { inherit pkgs; };
  mkEnv = fls.utils.mkEnv;
in
{
  wayland.windowManager.hyprland = {
    settings.env = [
      (mkEnv ["GDK_BACKEND" "wayland,x11,*"])
      (mkEnv ["QT_QPA_PLATFORM" "wayland;xcb"])
      (mkEnv ["QT_QPA_PLATFORMTHEME" "qt5ct"])
    ];
  };
}
