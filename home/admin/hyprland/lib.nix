{
  pkgs,
  ...
}:

let
  lib = pkgs.lib;
in
rec {
  utils = rec {
    mkEnv = biList:
    assert builtins.length biList == 2;
    {
      _args = [ (builtins.head biList) (builtins.head (builtins.tail biList)) ];
    };

    # TODO: When I actually care to modify this:
    # 1. listToLuaString should not take a list, but a set containing
    # { vars = [...]; raws = [...]; }, which would be way better than a random { val = ""; }

    # Transforms a list of variables / literals to a lua string
    # 1. { val = "mod"; } -> string: "mod .."
    # 2. "bash" -> string:"\"bash\" .."
    # For the list with (2.) and (1.), we would have the string "mod .. \"bash\""
    listToLuaString = list:
    let
      top = if list == [] then null else builtins.head list;
      rest = listToLuaString (builtins.tail list);
      sub = o1: o2:
        if builtins.typeOf top == "string" then o1
        else if builtins.hasAttr "val" top then o2
        else builtins.throw "Wrong type for lua string";
    in
      if builtins.length list <= 1 && top != null then sub "\"${top}\"" "${top.val}"
      else if top == null then ""
      else (sub "\"${top}\" .. " "${top.val} .. ") + rest;
  };

  lua = {
    mkExecDsp = { command, raw ? false }:
    let
      str = utils.listToLuaString command;
    in
      if raw
      then "hl.dsp.exec_raw(${str})"
      else "hl.dsp.exec_cmd(${str})";

    mkMoveXY = { x, y }: "hl.dsp.window.move({ x = ${builtins.toString x}, y = ${builtins.toString y}, relative = true})";

    mkResizeXY = { x, y }: "hl.dsp.window.resize({ x = ${builtins.toString x}, y = ${builtins.toString y}, relative = true})";

    mkBind = { input, luaCommandStr, flags ? {} }: {
      _args = [
        (lib.generators.mkLuaInline (utils.listToLuaString input))
        (lib.generators.mkLuaInline luaCommandStr)
        flags
      ];
    };
  };
}
