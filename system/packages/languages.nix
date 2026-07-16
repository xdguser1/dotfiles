{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    clang
    gcc
    gdb
    nodejs_24
    python314
    rustup
    texlab
    texliveGUST
    typescript
    valgrind
    zulu
  ];
}
