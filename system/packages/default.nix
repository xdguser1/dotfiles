{
  pkgs,
  ...
}:

{
  imports = [
    ./core.nix
    ./desktop.nix
    ./editors.nix
    ./network.nix
    ./languages.nix
  ];
}

