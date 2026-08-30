{
  pkgs,
  ...
}:

let
  flags = {
    mouse = true;
  };
  fls = import ../lib.nix { inherit pkgs; };
  lua = fls.lua;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "mod"; } " + Shift_L"];
          luaCommandStr = "hl.dsp.window.resize()";
        })
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "mod"; } " + Control_L"];
          luaCommandStr = "hl.dsp.window.drag()";
        })
      ];
    };
  };
}
