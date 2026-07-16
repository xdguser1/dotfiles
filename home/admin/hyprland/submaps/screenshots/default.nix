{
  pkgs,
  ...
}:

let
  fls = import ../../lib.nix { inherit pkgs; };
  lua = fls.lua;
  reset = "hl.dsp.submap(\"reset\")";
  execAndReset = { key, val }: lua.mkBind {
    input         = [key];
    luaCommandStr = ''
      function()
        ${lua.mkExecDsp { command = [{ inherit val; }]; }};
        ${reset};
      end
    '';
  };
in
{
  wayland.windowManager.hyprland = {
    settings.define_submap = [{
      _args = [
        "screenshots"
        (pkgs.lib.generators.mkLuaInline ''
        function()
          hl.bind("F", ${lua.mkExecDsp { command = [{ val = "scrshF"; }]; }}) 
          hl.bind("S", ${lua.mkExecDsp { command = [{ val = "scrshS"; }]; }}) 
          hl.bind("A", ${lua.mkExecDsp { command = [{ val = "scrshFS"; }]; }})
          hl.bind("M", ${lua.mkExecDsp { command = [{ val = "scrshM"; }]; }})
          hl.bind("N", ${lua.mkExecDsp { command = [{ val = "scrshFM"; }]; }})
          hl.bind("catchall", ${reset})
        end
        '')
      ];
    }];
  };
}
