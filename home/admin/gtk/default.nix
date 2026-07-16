{
  pkgs,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    dracula-qt5-theme
  ];

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "Dracula";
  };

  gtk = {
    enable = true;

    font = {
      name = "Ubuntu Nerd Font Medium";
      size = 8;
    };

    theme = {
      name    = "Nordic";
      package = pkgs.nordic;
    };

    iconTheme = {
      name    = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name    = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size    = 24;
    };

    colorScheme = "dark";
  };

  qt = {
    enable             = true;
    platformTheme.name = "gtk2";
  };

  home.pointerCursor = {
    enable = true;
    name       = "Nordzy-cursors";
    package    = pkgs.nordzy-cursor-theme;
    size       = 24;
    gtk.enable = true;
  };
}
