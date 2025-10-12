{
  description = "NixOS System Configuration";
 
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  { self, nixpkgs, home-manager, ... }@inputs:
  {
      nixosConfigurations.lfour = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
              inherit inputs;
          };
          modules = [
	   # System config
	   ./system

	    # Home config
            home-manager.nixosModules.home-manager
            {
                nixpkgs.overlays = import ./overlays;
		home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                  ];
                  users.lfour = { pkgs, ... }: {
                      imports = [ ./home ];
                  };
                };
            }
          ];
      };
  };
}
