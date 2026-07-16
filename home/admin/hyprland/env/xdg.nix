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
      (mkEnv ["XDG_CURRENT_DESKTOP" "Hyprland"])
      (mkEnv ["XDG_SESSION_TYPE" "wayland"])
      (mkEnv ["XDG_SESSION_DESKTOP" "Hyprland"])
    ];
  };
}
