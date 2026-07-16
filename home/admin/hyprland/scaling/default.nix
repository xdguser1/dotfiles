{
  ...
}:

{
  wayland.windowManager.hyprland = {
    settings = {
      config.xwayland.force_zero_scaling = true;

      monitor = [{
        _args = [{
          output   = "";
          mode     = "preferred";
          position = "auto";
          scale    = 1;
        }];
      }];
    };
  };
}
