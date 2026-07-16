{
  pkgs,
  astal,
  ags,
  ...
}:

{
  imports = [ ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    configDir = ./config;

    extraPackages = with astal.packages.${pkgs.system}; [
      battery
      bluetooth
      hyprland
      network
      wireplumber
    ] ++ [ pkgs.libadwaita ];
  };
}
