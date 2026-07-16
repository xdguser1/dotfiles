{
  ...
}:

{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      hl.bind(mod .. " + A", hl.dsp.exec_cmd(term))
      if hl.plugin.dynamic_cursors then
        hl.config({
          ["plugin"] = {
            ["dynamic_cursors"] = {
              ["enabled"]   = true,
              ["mode"]      = "stretch",
              ["threshold"] = 2,
            
              ["stretch"] = {
                ["limit"]    = 5000,
                ["function"] = linear,
                ["window"]   = 200,
              },
            
              ["shake"] = {
                ["enabled"] = false,
              },
            
              ["hyprcursor"] = {
                ["enabled"]    = true,
                ["nearest"]    = true,
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
