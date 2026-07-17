{
  ...
}:

{
  services.hypridle = {
    enable   = true;
    settings = {
      general = {
        after_sleep_cmd     = "hyprctl dispatch dpms on";
        before_sleep_cmd    = "loginctl lock session";
        ignore_dbus_inhibit = false;
        lock_cmd            = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout    = 370;
          on-timeout = "brightness -s set 20%";
          on-resume  = "brightness -r";
        }
        {
          timeout    = 600;
          on-timeout = "hyprlock";
        }
        {
          timeout    = 630;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume  = "hyprctl dispatch dpms on";
        }
        {
          timeout    = 1800;
          # Need swap file
          on-timeout = "systemctl hibernate";
        }
      ];
    };
  };
}
