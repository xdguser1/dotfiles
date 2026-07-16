{
  ...
}:

let
  mkRule = x: { _args = [x]; };
in
rec {
  wayland.windowManager.hyprland = {
    settings = {
      window_rule = [
        (mkRule {
          match = {
            class = "clipse";
          };
          animation = "popin";
          float     = true;
          size      = "622 652";
          pin       = true;
        })
      ];
    };
  };
}
