{
  pkgs,
  ...
}:

{
  services.flatpak.packages = [
    "app.zen_browser.zen"
  ];

  home.packages = with pkgs; [
    inkscape
    home-manager
    hyprshot
    nwg-look
    obs-studio
    oh-my-zsh
    qalculate-qt
    qemu
    texstudio
    typst
    xournalpp
  ] ++ (
    with pkgs.kdePackages; [
      okular
    ]
  );
}
