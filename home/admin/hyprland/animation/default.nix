{
  ...
}:

{
  wayland.windowManager.hyprland = {
    settings = {
      curve = [{
        _args = [
          "easeOutCubic"
          {
            type   = "bezier";
            points = [
              [0.33 1]
              [0.68 1]
            ];
          }
        ];
      }];

      animation = [
        {
          bezier  = "easeOutCubic";
          enabled = true;
          leaf    = "windows";
          style   = "slide";
          speed   = 2;
        }
      ];
    };
  };
}
