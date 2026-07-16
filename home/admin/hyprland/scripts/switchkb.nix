{
  pkgs,
  ...
}:

let
  fls      = import ../lib.nix { inherit pkgs; };
  kbscript = ".config/switchkb.sh";
  lua = fls.lua;
in
{
  home.file = {
    ${kbscript}.text = ''
      keyboard="$(hyprctl devices -j | jq '.keyboards[] | select(.main) | .name' -r)"
      hyprctl switchxkblayout $keyboard next;
    '';
  };

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        (lua.mkBind {
          input         = [{ val = "mod"; } " + space"];
          luaCommandStr = lua.mkExecDsp { command = ["sh ~/${kbscript}"]; };
        })
      ];
    };
  };
}
