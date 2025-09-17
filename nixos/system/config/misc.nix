{ config, pkgs, ... }:
{
  # Enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Emulate x86 machine to enable x86 support
  #boot.binfmt.emulatedSystems = [ "i686-linux" ];

  # Linux Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #NixOS Development
  environment.enableDebugInfo = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Set fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
	maple-mono.NF
	maple-mono.NF-CN
	minecraftia
	wqy_zenhei
  ];

  #System version
  system.stateVersion = "25.11";
}

