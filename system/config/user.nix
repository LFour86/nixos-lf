{ inputs, pkgs, ... }:

let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  # Define a user account.
  users.users.lfour = {
    isNormalUser = true;
    description = "LFour";
    extraGroups = [ "networkmanager" "wheel" "dialout"  "libvirtd" "video" "plugdev" "docker" "resolvconf" ];
    shell = unstable-pkgs.nushell;
  };
}

