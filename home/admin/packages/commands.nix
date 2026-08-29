{
  pkgs,
  notifs-piper,
  ...
}:

{
  home.packages = with pkgs; [
    cargo-generate
    delta
    fd
    ghc
    hunspell
    libqalculate
    mtr
    ncdu
    perf
    procs
    translate-shell
    viu
    wireplumber
    zsh
  ] ++ [
    notifs-piper.packages.${pkgs.system}.default
  ];
}
