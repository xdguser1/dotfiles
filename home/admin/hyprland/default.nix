{
  pkgs,
  ...
}:

{
  imports = [
    ./animation
    ./binds
    ./decoration
    ./env
    ./exec
    ./general
    ./gestures
    ./group
    ./hyprlock
    ./hyprpaper
    ./hypridle
    ./inputs
    ./misc
    ./packages
    ./plugins
    ./rules
    ./scaling
    ./scripts
    ./submaps
  ];

  wayland.windowManager.hyprland = {
    enable        = true;
    package       = null;
    portalPackage = null;
    configType    = "lua";

    xwayland.enable = true;

    settings = rec {
      # Browser
      zen._var      = "app.zen_browser.zen";
      runZen._var   = "flatpak run ${zen._var}";
      browser._var  = "${runZen._var}";
      fire._var     = "firefox";

      # Apps
      calc._var     = "qalculate-qt";
      code._var     = "${term._var} bash -c 'fzf | xargs nvim'";
      discord._var  = "vesktop";
      fmty._var     = "superfile";
      img._var      = "inkscape";
      music._var    = "nuclear";
      pen._var      = "xournalpp";
      picker._var   = "hyprpicker -a";
      status._var   = "${term._var} btop";
      term._var     = "kitty";
      tex._var      = "texstudio";

      # Control sequence
      start._var    = "CONTROL + ALT";
      startOpt._var = "${start._var} + SHIFT";
      mod._var      = "SUPER";

      opt1._var = "SHIFT";
      opt2._var = "CONTROL";
      opt3._var = "ALT";
      opt4._var = "${opt1._var} + ${opt2._var}";

      modOpt1._var = "${mod._var} + ${opt1._var}";
      modOpt2._var = "${mod._var} + ${opt2._var}";
      modOpt3._var = "${mod._var} + ${opt3._var}";
      modOpt4._var = "${mod._var} + ${opt4._var}";

      # System settings
      lockProg._var  = "hyprlock";
      lock._var      = "${lockProg._var}";
      reboot._var    = "systemctl reboot";
      poweroff._var  = "systemctl poweroff";
      hibernate._var = "systemctl hibernate";

      scrsh._var   = "hyprshot -z -m region --clipboard-only";
      scrshS._var  = "hyprshot -z -m region -o ~/images/screenshots";
      scrshF._var  = "hyprshot -z -m output --clipboard-only";
      scrshFS._var = "hyprshot -z -m output -o ~/images/screenshots";
      scrshM._var  = "hyprshot -z -m window --clipboard-only";
      scrshFM._var = "hyprshot -z -m window -o ~/images/screenshots";
    };
  };
}
