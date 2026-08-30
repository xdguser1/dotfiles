{
  pkgs,
  ...
}:

let
  flags = {
    click = true;
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
          input         = [{ val = "mod"; } " + mouse:273"];
          luaCommandStr = "hl.dsp.window.float()";
        })
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "mod"; } " + mouse:272"];
          luaCommandStr = "hl.dsp.window.close()";
        })
      ];
    };
  };
}
