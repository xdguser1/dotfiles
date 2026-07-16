{
 pkgs,
 ...
}:

let
  fls     = import ../lib.nix { inherit pkgs; };
  onStart = { cmd, rules ? "" }: {
    _args = [
      "hyprland.start"
      (pkgs.lib.generators.mkLuaInline "function() hl.exec_cmd(${fls.utils.listToLuaString cmd}, {${rules}}) end")
    ];
  };
in
{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      sub  = hl.on("window.open", function(wi)
        if wi.class == "app.zen_browser.zen" then
          hl.dispatch(hl.dsp.window.move({ window = wi.id, workspace = "2" }))
          sub:remove()
        end
      end)
    '';

    settings.on = builtins.map (onStart) [
      { cmd = ["ags run"]; }
      { cmd = ["hyprctl setcursor 'Nordzy-cursors' 24"]; }

      { cmd = [{ val = "status"; }];  rules = "workspace = \"1 silent\""; }
      { cmd = [{ val = "term"; }];    rules = "workspace = \"3 silent\""; }
      { cmd = [{ val = "browser"; }]; }
    ];
  };
}
