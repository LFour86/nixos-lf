{ pkgs, ... }:

{
  #enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  environment.systemPackages = with pkgs; [
    blueman bluez bluez-tools
  ];
}

