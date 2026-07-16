{
  pkgs,
  ...
}:

pkgs.stdenv.mkDerivation {
  pname   = "custom-grub";
  version = "1.0";

  src = [ ./. ];

  installPhase = ''
    mkdir -p $out
    cp -r . "$out"
  '';
}
