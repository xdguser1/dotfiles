{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    emacs
    neovim
    vim
  ];
}
