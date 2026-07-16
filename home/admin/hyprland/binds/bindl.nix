{
  pkgs,
  ...
}:

let
  flags = {
    locked = true;
  };
  fls = import ../lib.nix { inherit pkgs; };
  lua = fls.lua;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        # Utilities
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioNext"];
          luaCommandStr = lua.mkExecDsp { command = ["playerctl next"]; };
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioPrev"];
          luaCommandStr = lua.mkExecDsp { command = ["playerctl previous"]; };
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioPlay"];
          luaCommandStr = lua.mkExecDsp { command = ["playerctl play"]; };
        })
        (lua.mkBind {
          inherit flags;
          input         = ["XF86AudioPause"];
          luaCommandStr = lua.mkExecDsp { command = ["playerctl pause"]; };
        })
      ];
    };
  };
}
