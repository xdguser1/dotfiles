{
  pkgs,
  ...
}:

let
  startClipse = "if [ -z `pgrep 'clipse'` ]; then kitty --class clipse -e 'clipse'; fi;";
  fls         = import ../lib.nix { inherit pkgs; };
  lua         = fls.lua;

  mkExec = { mods, keys, command }: lua.mkBind {
    input         = (builtins.map (x: { val = x; }) mods) ++ keys;
    luaCommandStr = lua.mkExecDsp { inherit command; };
  };
in
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        # Windows
        (lua.mkBind {
          input         = [{ val = "mod"; } " + TAB"];
          luaCommandStr = "hl.dsp.window.cycle_next({})";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt1"; } " + TAB"];
          luaCommandStr = "hl.dsp.window.cycle_next({ next = \"prev\"; })";
        })

        # Tabs
        (lua.mkBind {
          input         = [{ val = "opt3"; } " + TAB"];
          luaCommandStr = "hl.dsp.group.next({})";
        })
        (lua.mkBind {
          input         = [{ val = "opt3"; } " + " { val = "opt1"; } " + TAB"];
          luaCommandStr = "hl.dsp.group.prev({})";
        })

        # Popup windows
        (mkExec {
          mods    = ["opt3"];
          keys    = [" + V"];
          command = ["$SHELL -c \\\"${startClipse}\\\""];
        })

        # Starts apps
        (mkExec {
          mods    = ["start"];
          keys    = [" + K"];
          command = ["okular"];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + B"];
          command = [{ val = "status"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + C"];
          command = [{ val = "code"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + D"];
          command = [{ val = "discord"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + G"];
          command = [{ val = "img"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + L"];
          command = ["libreoffice"];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + M"];
          command = [{ val = "music"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + P"];
          command = [{ val = "picker"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + Q"];
          command = [{ val = "calc"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + E"];
          command = [{ val = "pen"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + S"];
          command = [{ val = "scrsh"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + T"];
          command = [{ val = "term"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + X"];
          command = [{ val = "tex"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + Z"];
          command = [{ val = "browser"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + slash"];
          command = [{ val = "term"; } " " { val = "fmty"; }];
        })
        (mkExec {
          mods    = ["start"];
          keys    = [" + Shift_L + slash"];
          command = ["firefox"];
        })
        (lua.mkBind {
          input         = [{ val = "start"; } " + F"];
          luaCommandStr = "hl.dsp.submap(\"screenshots\")";
        })

        # Window control sequence
        (lua.mkBind {
          input         = [{ val = "mod"; } " + Q"];
          luaCommandStr = "hl.dsp.window.close({})";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt1"; } " + Q"];
          luaCommandStr = "hl.dsp.window.kill({})";
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + T"];
          luaCommandStr = lua.mkExecDsp {
            command = [{ val = "term"; }];
          };
        })

        # Window behaviour
        (lua.mkBind {
          input         = [{ val = "mod"; } " + F"];
          luaCommandStr = "hl.dsp.window.float({ action = \"toggle\" })";
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + P"];
          luaCommandStr = "hl.dsp.window.pin({})";
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + C"];
          luaCommandStr = "hl.dsp.window.center({})";
        })

        # Window Resizing
        (lua.mkBind {
          input         = [{ val = "mod"; } " + equal"];
          luaCommandStr = "hl.dsp.window.fullscreen({ action = \"toggle\" })";
        })

        (lua.mkBind {
          input         = [{ val = "modOpt3"; } " + right"];
          luaCommandStr = "hl.dsp.window.swap({ direction = \"right\" })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt3"; } " + left"];
          luaCommandStr = "hl.dsp.window.swap({ direction = \"left\" })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt3"; } " + up"];
          luaCommandStr = "hl.dsp.window.swap({ direction = \"up\" })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt3"; } " + down"];
          luaCommandStr = "hl.dsp.window.swap({ direction = \"down\" })";
        })

        (lua.mkBind {
          input         = [{ val = "modOpt4"; } " + right"];
          luaCommandStr = "hl.dsp.window.move({ direction = \"right\", group_aware = true, })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt4"; } " + left"];
          luaCommandStr = "hl.dsp.window.move({ direction = \"left\", group_aware = true, })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt4"; } " + up"];
          luaCommandStr = "hl.dsp.window.move({ direction = \"up\", group_aware = true, })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt4"; } " + down"];
          luaCommandStr = "hl.dsp.window.move({ direction = \"down\", group_aware = true, })";
        })

        # Focus
        (lua.mkBind {
          input         = [{ val = "mod"; } " + right"];
          luaCommandStr = "hl.dsp.focus({ direction = \"right\" })";
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + left"];
          luaCommandStr = "hl.dsp.focus({ direction = \"left\" })";
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + up"];
          luaCommandStr = "hl.dsp.focus({ direction = \"up\" })";
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + down"];
          luaCommandStr = "hl.dsp.focus({ direction = \"down\" })";
        })

        # Groups
        (lua.mkBind {
          input         = [{ val = "modOpt1"; } " + T"];
          luaCommandStr = "hl.dsp.group.toggle({})";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt1"; } " + L"];
          luaCommandStr = "hl.dsp.group.lock_active({ action = \"toggle\" })";
        })

        # System
        (mkExec {
          mods    = ["mod"];
          keys    = [" + L"];
          command = [{ val = "lock"; }];
        })
        (mkExec {
          mods    = ["mod"];
          keys    = [" + R"];
          command = [{ val = "reboot"; }];
        })
        (mkExec {
          mods    = ["mod"];
          keys    = [" + O"];
          command = [{ val = "poweroff"; }];
        })
        (mkExec {
          mods    = ["mod"];
          keys    = [" + H"];
          command = [{ val = "hibernate"; }];
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + E"];
          luaCommandStr = "hl.dsp.exit()";
        })

        # Workspace
        (lua.mkBind {
          input         = [{ val = "mod"; } " + period"];
          luaCommandStr = "hl.dsp.focus({ workspace = \"r+1\" })";
        })
        (lua.mkBind {
          input         = [{ val = "mod"; } " + comma"];
          luaCommandStr = "hl.dsp.focus({ workspace = \"r-1\" })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt2"; } " + period"];
          luaCommandStr = "hl.dsp.window.move({ workspace = \"r+1\", focus = true, })";
        })
        (lua.mkBind {
          input         = [{ val = "modOpt2"; } " + comma"];
          luaCommandStr = "hl.dsp.window.move({ workspace = \"r-1\", focus = true, })";
        })
      ] ++ (
        builtins.tail (
          builtins.genList (
            x:
            let
              y = builtins.toString x;
            in
              (lua.mkBind {
                input         = [{ val = "mod"; } " + ${y}"];
                luaCommandStr = "hl.dsp.focus({ workspace = ${y} })";
              })
          ) 
        10) ++ [ 
          (lua.mkBind {
            input         = [{ val = "mod"; } " + 0"];
            luaCommandStr = "hl.dsp.focus({ workspace = 10 })";
          })
        ]
      ) ++ (
        builtins.tail (
          builtins.genList (
            x:
            let
              y = builtins.toString x;
            in
              (lua.mkBind {
                input         = [{ val = "modOpt2"; } " + ${y}"];
                luaCommandStr = "hl.dsp.window.move({ workspace = ${y}, focus = true, })";
              })
          ) 10
        ) ++ [ 
          (lua.mkBind {
            input         = [{ val = "modOpt2"; } " + 0"];
            luaCommandStr = "hl.dsp.window.move({ workspace = 10, focus = true, })";
          })
        ]
      );
    };
  };
}
