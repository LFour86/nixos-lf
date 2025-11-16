{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.lfour = nixpkgs.lib.nixosSystem {
      inherit system;

      # no need to pass pkgs through specialArgs unless you really want to
      specialArgs = { inherit inputs; };

      modules = [
        # System config
        ./system

        # Proper nixpkgs configuration module
        {
          nixpkgs = {
            overlays = import ./overlays;
            config.allowUnfree = true;
          };
        }

        # Home Manager Integration
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.lfour = {
              imports = [ ./home ];
            };
          };
        }
      ];
    };
  };
}

