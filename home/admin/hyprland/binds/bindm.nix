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
          input         = [{ val = "mod"; } " + mouse:273"];
          luaCommandStr = "hl.dsp.window.resize()";
        })
        (lua.mkBind {
          inherit flags;
          input         = [{ val = "mod"; } " + mouse:272"];
          luaCommandStr = "hl.dsp.window.drag()";
        })

        # Note to self : Shift_L is a key. Putting modOpt1 and modOpt2 won't work since
        # modOpt1 is CTRL (a modifier) and not a key.
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
