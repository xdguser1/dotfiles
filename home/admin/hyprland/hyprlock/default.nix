{
  ...
}:

{
  programs.hyprlock = {
    enable   = true;
    settings = {
      general = {
        hide_cursor  = true;
        fail_timeout = 500;
      };

      animations = {
        enabled   = true;

        bezier = [
          "linear, 1, 1, 0, 0"
          "fastin, 0.07, 0.81, 0.5, 1.01"
        ];

        animation = [
          "inputFieldDots, 1, 0.5,  linear"
          "fadeIn,         1, 0.75, fastin"
          "fadeOut,        1, 0.4,  linear"
        ];
      };

      background = {
          path        = "screenshot";
          blur_passes = 3;
      };

      input-field = [
        {
          size              = "20%, 3%";
          outline_thickness = 2;

          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0)";
          check_color = "rgba(0, 0, 0, 0)";
          fail_color  = "rgba(0, 0, 0, 0)";

          font_color    = "rgb(255, 255, 255)";
          rounding      = 5;

          font_family      = "Ubuntu Nerd Font Medium";
          placeholder_text = "";
          fail_text        = "";

          dots_text_format = "·";
          dots_size        = 0.8;
          dots_spacing     = 0.3;

          position = "0, -20";
          halign   = "center";
          valign   = "center";

          shadow_passes = 3;
          shadow_size   = 10;
          shadow_color  = "rgb(0, 0, 0)";
        }
      ];
    };
  };
}
