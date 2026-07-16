{
  pkgs,
  ...
}:

let
  flags = {
    locked    = true;
    repeating = true;
  };
  fls = import ../lib.nix { inherit pkgs; };
  lua = fls.lua;
  mkExecDsp = x: lua.mkExecDsp { command = x; };
in
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioRaiseVolume"];
          luaCommandStr = mkExecDsp ["wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"];
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioLowerVolume"];
          luaCommandStr = mkExecDsp ["wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"];
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioMute"];
          luaCommandStr = mkExecDsp ["wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"];
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioMicMute"];
          luaCommandStr = mkExecDsp ["wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"];
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86MonBrightnessUp"];
          luaCommandStr = mkExecDsp ["brightnessctl -e4 -n2 set 5%+"];
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86MonBrightnessDown"];
          luaCommandStr = mkExecDsp ["brightnessctl -e4 -n2 set 5%-"];
        })
      ];
    };
  };
}
