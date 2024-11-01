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

  home-manager = {
    users.zeno = {
      home = {
        stateVersion = "24.05";
        packages = with pkgs; [
          nixfmt-rfc-style
          pavucontrol
          obsidian
        ];
      };

      xsession.windowManager.i3 = {
        enable = true;
        config = {
          terminal = "kitty";
        };
      };

      programs = {
        kitty.enable = true;
        brave.enable = true;
        git = {
          enable = true;
          extraConfig.core.editor = "nvim";
          userName = "Zeno343";
          userEmail = "zeno@outernet.digital";
          hooks = {
            pre-commit = pkgs.writeShellScript "nixfmt" ''
              #!/bin/bash
              nixfmt -c $(find . -name "*.nix")
            '';
          };
        };

        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        neovim = with pkgs; {
          enable = true;
          defaultEditor = true;
          extraPackages = [ nixd ];
          plugins = with vimPlugins; [
            {
              plugin = nvim-lspconfig;
              type = "lua";
              config = ''require("lspconfig").nixd.setup{}'';
            }
          ];
        };
      };
    };
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
