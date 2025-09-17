{
  description = "NixOS System Configuration";
 
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #hyprland.url = "github:hyprwm/Hyprland";
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
            home-manager.nixosModules.home-manager
            {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  sharedModules = [
                  ];
                  users.lfour = { pkgs, ... }: {
                      imports = [
                        ./home.nix
                      ];
                  };
                };
            }
            ###### Hardware Configuration #####################
            ./system/hardware/amdgpu.nix
            ./system/hardware/audio.nix
            ./system/hardware/bluetooth.nix
            ./system/hardware/camera.nix
            ./system/hardware/partition.nix
            ./system/hardware/nvidia.nix
            ###################################################
            ###### System Configuration #######################
            ./system/config/bootloader.nix
            ./system/config/desktop.nix
            ./system/config/environment-variables.nix 
            ./system/config/layout.nix
            ./system/config/misc.nix
            ./system/config/powermanager.nix 
            ./system/config/security.nix 
            ./system/config/user.nix
            ./system/config/network.nix 
            ##################################################
            ###### System Programs ###########################
            ./system/programs/programs.nix 
            ./system/programs/services.nix
            ./system/programs/ssh.nix
	    ./system/programs/systempkgs.nix
            ./system/programs/virtualisation.nix
            ##################################################
          ];
      };
  };
}
