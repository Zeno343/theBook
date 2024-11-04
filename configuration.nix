{ pkgs, ... }:
{
  system.stateVersion = "24.05";
  time.timeZone = "America/New_York";
  imports = [ ./hardware-configuration.nix ];

  users.users.zeno = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "audio"
      "video"
      "wheel"
    ];
  };

  programs = {
    fish.enable = true;
  };

  networking = {
    hostName = "lab";
    networkmanager.enable = true;
  };

  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.graphics.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
