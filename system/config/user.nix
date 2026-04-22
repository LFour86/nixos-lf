{ inputs, pkgs, ... }:

let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  # Define user account.
  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPasswordFile = "/persist/passwords/root";
      };
      lfour = {
        isNormalUser = true;
        hashedPasswordFile = "/persist/passwords/lfour";
        description = "LFour";
        extraGroups = [ "networkmanager" "wheel" "dialout"  "libvirtd" "video" "audio" "plugdev" "docker" "resolvconf" ];
        shell = unstable-pkgs.nushell;
      }
    };
  };
}
