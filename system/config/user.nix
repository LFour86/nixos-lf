{ pkgs, ... }:
{
  # Define a user account.
  users.users.lfour = {
    isNormalUser = true;
    description = "LFour";
    extraGroups = [ "networkmanager" "wheel" "dialout"  "libvirtd" "video" "plugdev" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };
}

