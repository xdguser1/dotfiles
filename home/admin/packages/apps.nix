{
  pkgs,
  ...
}:

{
  services.flatpak.packages = [
    "app.zen_browser.zen"
  ];

  home.packages = with pkgs; [
    gimp
    home-manager
    hyprshot
    nwg-look
    nuclear
    obs-studio
    oh-my-zsh
    openocd
    qalculate-qt
    qemu
    qtcreator
    texstudio
    typst
    xournalpp
  ] ++ (
    with pkgs.kdePackages; [
        okular
    ]
  );
}
