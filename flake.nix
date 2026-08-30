{
  description = "NixOS configuration";

  inputs = rec {
    nixpkgs.url = "path:/home/admin/docs/code/nixpkgs";
  
    nix-flatpak.url  = "https://flakehub.com/f/gmodena/nix-flatpak/0.7.0";
  
    notifs-piper = {
      url                    = "github:xdguser1/notifs-piper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    hyprland = {
      url                    = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    astal = {
      url                    = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    ags = {
      url    = "github:aylur/ags";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        astal.follows   = "astal";
      };
    };
  
    home-manager = {
      url                    = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    hyprcursor = {
      url    = "github:hyprwm/hyprcursor";
      inputs = {
        nixpkgs.follows  = "nixpkgs";
        hyprlang.follows = "hyprland/hyprlang";
      };
    };
  
    hyprlock = {
      url    = "github:hyprwm/hyprlock";
      inputs = {
        nixpkgs.follows             = "nixpkgs";
        hyprgraphics.follows        = "hyprland/hyprgraphics";
        hyprutils.follows           = "hyprland/hyprutils";
        hyprlang.follows            = "hyprland/hyprlang";
        hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
      };
    };
  
    hypridle = {
      url    = "github:hyprwm/hypridle";
      inputs = {
        nixpkgs.follows             = "nixpkgs";
        hyprlang.follows            = "hyprland/hyprlang";
        hyprutils.follows           = "hyprland/hyprutils";
        hyprland-protocols.follows  = "hyprland/hyprland-protocols";
        hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
      };
    };
  
    hyprpaper = {
      url    = "github:hyprwm/hyprpaper";
      inputs = {
        nixpkgs.follows             = "nixpkgs";
        aquamarine.follows          = "hyprland/aquamarine";
        hyprgraphics.follows        = "hyprland/hyprgraphics";
        hyprutils.follows           = "hyprland/hyprutils";
        hyprlang.follows            = "hyprland/hyprlang";
        hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
        hyprwire.follows            = "hyprland/hyprwire";
      };
    };
  
    hyprpicker = {
      url    = "github:hyprwm/hyprpicker";
      inputs = {
        nixpkgs.follows             = "nixpkgs";
        hyprutils.follows           = "hyprland/hyprutils";
        hyprwayland-scanner.follows = "hyprland/hyprwayland-scanner";
      };
    };

    hypr-dynamic-cursors = {
      url    = "github:VirtCode/hypr-dynamic-cursors";
      inputs = {
        nixpkgs.follows  = "nixpkgs";
        hyprland.follows = "hyprland";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    notifs-piper,
    home-manager,
    hyprland,
    nix-flatpak,
    ags,
    astal,
    ...
  }@inputs:
  {
    nixosConfigurations = {
      admin = nixpkgs.lib.nixosSystem rec {
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          notifs-piper.nixosModules.default
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
          home-manager
          hyprland
          nix-flatpak
          ags
          notifs-piper
          astal
          inputs;

          colors = import ./colors.nix;
          hyprland-community = {
            inherit (inputs)
            hyprcursor
            hyprlock
            hypridle
            hyprpaper
            hypr-dynamic-cursors
            hyprpicker;
          };
        };
      };
    };
  };
}
