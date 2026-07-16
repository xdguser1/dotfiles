{
  ...
}:

{
  wayland.windowManager.hyprland = {
    settings.config.input = {
      # Keyboard relative
      kb_layout  = "us,us,ca";
      kb_variant = "colemak,,";

      numlock_by_default = true;

      repeat_rate  = 40;
      repeat_delay = 250;

      # Mouse relative
      accel_profile = "flat";
      scroll_method = "2fg";

      sensitivity = 0.4;

      touchpad = {
        natural_scroll = true;
        scroll_factor  = 0.75;
      };
    };
  };
}
