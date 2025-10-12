{ config, pkgs, ... }:
{
  # Enable Flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Linux Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # For Development/Debugging
  #environment.enableDebugInfo = true;

  # Set Timezone.
  time.timeZone = "Asia/Shanghai";

  # Set Fonts
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
	maple-mono.NF
	maple-mono.NF-CN
	minecraftia
	wqy_zenhei
  ];

  #System Version
  system.stateVersion = "25.11";
}
