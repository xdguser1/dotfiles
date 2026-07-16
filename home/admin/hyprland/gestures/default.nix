{
  pkgs,
  ...
}:

let
  fls    = import ../lib.nix { inherit pkgs; };
  mkGest = x:
  let
    y = x // {
    action = if builtins.hasAttr "str" x then x.action else pkgs.lib.mkLuaInline ''
      function()
        ${x.action}
      end
      '';
    };
  in
  { _args = [ y ]; };
in
{
  wayland.windowManager.hyprland = {
    settings.config.gestures = {
      workspace_swipe_cancel_ratio = 0.3;
      workspace_swipe_distance = 200;
    };

    settings.gesture = [
      # Window switching
      (mkGest {
        fingers   = 3;
        direction = "horizontal";
        action    = "workspace";
        str       = true;
      })

      # Window moving
      (mkGest {
        fingers   = 3;
        direction = "right";
        mods      = pkgs.lib.generators.mkLuaInline "mod";
        action    = "hl.dispatch(hl.dsp.window.move({ workspace = \"r+1\" }))";
      })
      (mkGest {
        fingers   = 3;
        direction = "left";
        mods      = pkgs.lib.generators.mkLuaInline "mod";
        action    = "hl.dispatch(hl.dsp.window.move({ workspace = \"r-1\" }))";
      })

      # Toggling options
      (mkGest {
        fingers   = 4;
        direction = "down";
        action    = "hl.dispatch(${fls.lua.mkExecDsp { command = [{ val = "lock"; }]; }})";
      })
      (mkGest {
        fingers   = 4;
        direction = "up";
        action    = "fullscreen";
        str       = true;
      })
    ];
  };
}
