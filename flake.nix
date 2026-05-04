{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";      # Offical 
    #nixpkgs.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-25.11&shallow=1";      # Mirror 
    #nixpkgs.url = "git+file:///etc/nixos/inputs/nixpkgs-25.11?ref=nixos-25.11";      # Local 

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";      # Offical 
    #nixpkgs-unstable.url = "git+https://mirrors.tuna.tsinghua.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";      # Mirror 
    #nixpkgs-unstable.url = "git+file:///etc/nixos/inputs/nixpkgs-unstable?ref=nixos-unstable";      # Local 

    disko = {
      url = "github:nix-community/disko";      # Offical 
      #url = "git+file:///etc/nixos/inputs/disko?ref=master";      # Local 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";      # Offical
      #url = "git+file:///etc/nixos/inputs/impermanence?ref=master";      # Local 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";      # Offical
      #url = "git+file:///etc/nixos/inputs/home-manager?ref=release-25.11";      # Local 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";      # Offical 
      #url = "git+file:///etc/nixos/inputs/noctalia-shell?ref=main";      # Local
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, impermanence, home-manager, ... }@inputs:
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
            overlays = [
              (import ./overlays)
            ];
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

        # File System
        disko.nixosModules.default
        impermanence.nixosModules.impermanence
      ];
    };
  };
}

