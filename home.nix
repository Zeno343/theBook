{ pkgs, ... }:
{
  home = {
    stateVersion = "24.05";
    username = "zeno";
    homeDirectory = "/home/zeno";
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
}
