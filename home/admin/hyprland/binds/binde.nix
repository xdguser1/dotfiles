{
  pkgs,
  ...
}:

let
  flags = {
    repeating = true;
  };
  mod = { val = "modOpt1"; };

  fls = import ../lib.nix { inherit pkgs; };
  lua = fls.lua;
in
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "modOpt2"; } " + right"];
          luaCommandStr = lua.mkMoveXY { x = 10; y = 0; };
        })
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "modOpt2"; } " + left"];
          luaCommandStr = lua.mkMoveXY { x = -10; y = 0; };
        })
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "modOpt2"; } " + up"];
          luaCommandStr = lua.mkMoveXY { x = 0; y = 10; };
        })
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "modOpt2"; } " + down"];
          luaCommandStr = lua.mkMoveXY { x = 0; y = -10; };
        })

        (lua.mkBind {
          inherit flags;
          input = [(mod) " + right"];
          luaCommandStr = lua.mkResizeXY { x = 10; y = 0; };
        })
        (lua.mkBind {
          inherit flags;
          input = [(mod) " + left"];
          luaCommandStr = lua.mkResizeXY { x = -10; y = 0; };
        })
        (lua.mkBind {
          inherit flags;
          input = [(mod) " + up"];
          luaCommandStr = lua.mkResizeXY { x = 0; y = 10; };
        })
        (lua.mkBind {
          inherit flags;
          input = [(mod) " + down"];
          luaCommandStr = lua.mkResizeXY { x = 0; y = -10; };
        })
      ];
    };
  };
}
