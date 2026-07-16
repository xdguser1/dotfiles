{
 pkgs,
 ...
}:

let
  fls     = import ../lib.nix { inherit pkgs; };
  onStart = { cmd, rules ? "" }: {
    _args = [
      "hyprland.start"
      (pkgs.lib.generators.mkLuaInline "function() hl.exec_cmd(${fls.utils.listToLuaString [cmd]}, {${rules}}) end")
    ];
  };
in
{
  wayland.windowManager.hyprland = {
    settings.on = builtins.map (onStart) [
      { cmd = "ags run"; }
      { cmd = "hyprctl setcursor 'Nordzy-cursors' 24"; }

      { cmd = "hyprctl dispatch workspace 2"; }
      { cmd = { val = "status"; };  rules = "workspace = \"1 silent\""; }
      { cmd = { val = "browser"; }; rules = "workspace = \"2 silent\""; }
      { cmd = { val = "term"; };    rules = "workspace = \"3 silent\""; }
    ];
  };
}
