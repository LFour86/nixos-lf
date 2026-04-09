{ inputs, lib, pkgs, ... }:

let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  home.packages = with pkgs;[
    unstable-pkgs.bilibili
    musicpod
    sillytavern
    unstable-pkgs.spotify
    unstable-pkgs.lutris
    unstable-pkgs.protonplus
  ];
}

