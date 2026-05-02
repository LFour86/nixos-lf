{ inputs, lib, pkgs, ... }:

let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs;[
    arduino-ide
    freecad
    jetbrains.clion
    jetbrains.pycharm
    kicad
    kicadAddons.kikit
    octaveFull
    stm32cubemx
    unstable-pkgs.opencode
    #unstable-pkgs.zed-editor
  ];
}

