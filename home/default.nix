{ inputs, ... }:

{
  imports = [
    # Modules
    inputs.noctalia-shell.homeModules.default
    
    # Home-manager module
    ./home-manager.nix

    # Users config
    ./config
    
    # Users programs
    ./programs
    
    # Users packages
    ./userpkgs
  ];
}

