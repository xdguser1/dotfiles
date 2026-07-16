{
  pkgs,
  ...
}:

{
  imports = [
    ./apps.nix
    ./commands.nix
    ./libs.nix
  ];
}
