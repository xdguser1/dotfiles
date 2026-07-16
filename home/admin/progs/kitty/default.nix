{
  pkgs,
  ...
}:

{
  programs.kitty = {
    enable    = true;
    themeFile = "tokyo_night_storm";

    font = {
      size = 11;
      name = "Liberation Mono";
    };

    settings = {
      confirm_os_window_close = 0;

      cursor_shape           = "beam";
      cursor_shape_unfocused = "underline";

      cursor_trail = 1;

      scrollback_lines = 3000;

      url_style            = "straight";
      underline_hyperlinks = "always";

      shell = "zsh";
    };

    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;
  };
}
