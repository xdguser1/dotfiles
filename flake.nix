# Flakes configuration. Specifies the input urls and
# external packages.
#
# This should not make any changes to configuration files,
# only import them.
{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    hyprland.url    = "github:hyprwm/Hyprland";
    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.7.0";

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    hyprland,
    nix-flatpak,
    ags,
    astal,
    ...
  }:
  {
    nixosConfigurations = {
      admin = nixpkgs.lib.nixosSystem rec {
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          {
            nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
             # Quote from albert's license:
             #
             # > This is basically a BSD-2-Clause without the permission for redistribution
             # > of modifications and an explicit exclusion of Microsoft or Apple platforms.
             #
             # So, even if nixpkgs considers this unfree, it can be tolerated.
             # Plus, it's a rare linux exclusive, which is always fun.
             "albert"
             "cmd-parser.nvim"
           ];
          }
          {
            home-manager = {
              useGlobalPkgs   = true;
              useUserPackages = true;

              backupFileExtension = "backup";

              sharedModules = [
                 nix-flatpak.homeManagerModules.nix-flatpak
              ];

              users = {
                admin.imports = [
                  ./home/admin
                ];
              };

              extraSpecialArgs = specialArgs;
            };
          }
        ];

        specialArgs = {
           inherit
           flake-utils
           home-manager
           hyprland
           nix-flatpak
           ags
           astal;
           inherit (self) inputs;

           # Credit goes to author: Michaël Ball
           # Based on Tokyo Night by enkia (https://github.com/enkia/tokyo-night-vscode-theme)
           colors = {
             transformARGB = color: alpha: "#" + alpha + (builtins.substring 1 6 color);
             base00 = "#24283B"; # Background
             base01 = "#16161E"; # Lighter background (terminal black)
             base02 = "#343A52"; # Selection background
             base03 = "#444B6A"; # Comments, invisibles
             base04 = "#787C99"; # Dark foreground
             base05 = "#A9B1D6"; # Default foreground
             base06 = "#CBCCD1"; # Light foreground
             base07 = "#D5D6DB"; # Lightest foreground
             base08 = "#C0CAF5"; # Variables, XML tags
             base09 = "#A9B1D6"; # Integers, booleans
             base0A = "#0DB9D7"; # Classes, search text bg
             base0B = "#9ECE6A"; # Strings
             base0C = "#B4F9F8"; # Regex, escape chars
             base0D = "#2AC3DE"; # Functions, methods
             base0E = "#BB9AF7"; # Keywords, storage
             base0F = "#F7768E"; # Deprecated, special
             base10 = "#1F2335"; # Darker background
             base11 = "#1A1B26"; # Darkest background
             base12 = "#FF7A93"; # Bright red
             base13 = "#FF9E64"; # Bright orange
             base14 = "#73DACA"; # Bright green/teal
             base15 = "#7DCFFF"; # Bright cyan
             base16 = "#89DDFF"; # Bright blue
             base17 = "#BB9AF7"; # Bright magenta
          };
        };
      };
    };
  };
}
