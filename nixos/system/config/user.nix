{ pkgs, ... }:
{
  # Define a user account.
  users.users.lfour = {
    isNormalUser = true;
    description = "LFour";
    extraGroups = [ "networkmanager" "wheel" "dialout"  "libvirtd" "video" "plugdev" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };
}

