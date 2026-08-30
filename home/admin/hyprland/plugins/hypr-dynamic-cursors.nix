{
  ...
}:

{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      if hl.plugin.dynamic_cursors then
        hl.config({
          ["plugin"] = {
            ["dynamic_cursors"] = {
              ["enabled"]   = true,
              ["mode"]      = "stretch",
              ["threshold"] = 2,
            
              ["stretch"] = {
                ["limit"]    = 5000,
                ["activation"] = "linear",
                ["window"]   = 200,
              },
            
              ["shake"] = {
                ["enabled"] = false,
              },
            
              ["hyprcursor"] = {
                ["enabled"]    = true,
                ["nearest"]    = 1,
                ["resolution"] = -1,
                ["fallback"]   = "clientside",
              },
            },
          }
        })
      end
    '';
  };
}
