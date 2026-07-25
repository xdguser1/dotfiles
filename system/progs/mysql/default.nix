{
  pkgs,
  ...
}:

{
  services.mysql = {
    enable  = false;
    user    = "root";
    package = pkgs.mysql84;
  };
}
