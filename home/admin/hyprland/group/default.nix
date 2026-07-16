{
  ...
}:

{
  wayland.windowManager.hyprland = {
    settings.config.group = {
      col = {
        border_active   = "0xcc0e9b63";
        border_inactive = "0xcc0c734a";
        border_locked_active   = "0xcc961212";
        border_locked_inactive = "0xcc770e0e";
      };

      groupbar = {
        col = {
          active   = "0xcc0e9b63";
          inactive = "0xcc0c734a";

          locked_active   = "0xcc961212";
          locked_inactive = "0xcc770e0e";
        };

        gaps_out         = 0;
        height           = 0;
        indicator_height = 0;
        keep_upper_gap   = false;

        render_titles  = false;
        rounding       = 2;
        rounding_power = 2;
      };
    };
  };
}
