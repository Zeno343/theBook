{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        lab =
          let
            pkgs = import nixpkgs {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit pkgs;
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
            ];
          };
      };
    };
}
