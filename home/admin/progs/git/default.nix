{
  ...
}:

{
  programs.git = {
    enable = true;

    includes = [
     {
       path = "~/nixos/home/admin/progs/git/git-private.inc";
     }
    ];

    signing = {
      # The rest of it (i.e. which key to use)
      # is defined in the private part
      format        = "ssh";
      signByDefault = true;
    };

    settings = {
      diff = {
        tool    = "kitty";
        guitool = "kitty.gui";
      };

      difftool = {
        prompt        = false;
        trustExitCode = true;
      };

      "difftool \"kitty\"" = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };

      "difftool \"kitty.gui\"" = {
        cmd = "kitten diff $LOCAL $REMOTE";
      };
    };
  };
}
