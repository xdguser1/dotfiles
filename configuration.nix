{
  hyprland,
  lib,
  pkgs,
  ...
}:

rec {
  imports = [
    ./hardware-configuration.nix
    ./system
  ];

  hardware.keyboard.zsa.enable = true;

  hardware.bluetooth = {
    enable      = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental    = true;
        FastConnectable = true;
      };

      Policy = {
        AutoEnable = true;
      };
    };
  };

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "poweroff";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.displayManager.enable = true;

  xdg.portal.wlr.enable = true;

  systemd.services.lidm.enable = false;
  services.xserver.displayManager.lightdm.enable = false;
  services.displayManager.sddm.enable = true;

  services.notifs-piper = {
    enable     = true;
    max        = 10;
    auto-close = true;
    timeout    = 10000;
  };

  programs.hyprland = {
    enable          = true;
    xwayland.enable = true;
    withUWSM        = true;
  };

  networking.hostName = "nixos";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.flatpak.enable = true;

  services.printing.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  services.upower.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
  nix.settings.auto-optimise-store = true;

  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };

  services.openssh.enable = true;

  system.stateVersion = "26.05";
}
