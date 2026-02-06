{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.lfour = nixpkgs.lib.nixosSystem {
      inherit system;

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
            backupFileExtension = "backup";
            
            extraSpecialArgs = {
              inherit inputs;
            
            };
            users.lfour = {
              imports = [ ./home ];
            };
          };
        }
      ];
    };
  };
}

