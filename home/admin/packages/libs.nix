{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    cargo-binutils
  ];
}
