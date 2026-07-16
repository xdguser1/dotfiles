{
  pkgs,
  ...
}:

let
  lib = pkgs.lib;
in {
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--style full"
      "--preview='bat --style=\\\"changes,numbers\\\" --color=\\\"always\\\" --decorations=\\\"always\\\" {}'"
      "--bind 'focus:transform-preview-label:[[ -n {} ]] && printf \\\"File: %s\\\" {}'"
      "--color 'bg:#24283b'"
      "--color 'border:#aaaaaa'"
      "--color 'header-border:#6699cc'"
      "--color 'header-label:#99ccff'"
      "--color 'input-border:#996666'"
      "--color 'input-label:#ffcccc'"
      "--color 'label:#cccccc'"
      "--color 'list-border:#669966'"
      "--color 'list-label:#99cc99'"
      "--color 'preview-border:#9999cc'"
      "--color 'preview-label:#ccccff'"
    ];
  };

  programs.zsh = {
    enable = true;

    history  = {
      expireDuplicatesFirst = true;
      extended              = true;
    };

    sessionVariables = {
      EDITOR    = "nvim";
      SHELL     = "zsh";
    };

    oh-my-zsh = {
      enable  = true;
      theme   = "crcandy";
      plugins = [
        "aliases"
        "docker"
        "emoji"
        "eza"
        "fancy-ctrl-z"
        "gh"
        "git"
        "procs"
        "rust"
        "wd"
        "zoxide"
      ];
    };

    syntaxHighlighting = {
      enable = true;
    };

    shellAliases = {
      # Is expanded anywhere on the line, not just at the beginning
      nrt  = "sudo nixos-rebuild test         --flake /home/admin/nixos#admin";
      nrtr = "sudo nixos-rebuild test         --flake /home/admin/nixos#admin --rollback";
      nrs  = "sudo nixos-rebuild switch       --flake /home/admin/nixos#admin";
      nrsr = "sudo nixos-rebuild switch       --flake /home/admin/nixos#admin --rollback";
      nrda = "sudo nixos-rebuild dry-activate --flake /home/admin/nixos#admin";
      nrlg = "nixos-rebuild list-generations";
      nr   = "sudo nixos-rebuild";
      qc   = "qalc";

      b    = "bat";
      gdk  = "git difftool --no-symlinks --dir-diff";
      gdsk = "git difftoll --no-symlinks --dir-diff --staged";
      v    = "nvim";
      zs   = ''
      TARGD="$(realpath `fzf`)"
      if [ -d "$TARGD" ]; then
        z "$TARGD";
      else
        z "$(dirname $TARGD)";
      fi
      unset TARGD;
      '';
      fv = "fzf | xargs nvim";
    };

    dirHashes = {
      docs = "~/Documents";
    };
  };
}
