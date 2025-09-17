{ ... }:
{
  #Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.username = "lfour";
  xdg.configFile."powerdevilrc".text = ''
      [AC][DPMSControl]
      idleTime=7200000 # ms, 0 --> disable
      sleepTime=0 # s, 0 --> disable

      [Battery][DPMSControl]
      idleTime=1200000 # ms
      sleepTime=1800   # s
  '';
  home.homeDirectory = "/home/lfour";
  imports = [
	./home/llm.nix
	./home/programs.nix 
	./home/userpkgs.nix
	./home/config/fastfetch.nix
	./home/config/hyprland/dunst.nix
	./home/config/hyprland/hypridle.nix
	./home/config/hyprland/hyprland.nix
	./home/config/hyprland/hyprlock.nix
	./home/config/hyprland/waybar-config.nix
	./home/config/hyprland/waybar-style-css.nix
	./home/config/hyprland/wofi.nix 
  ];

  #Home-manager version
  home.stateVersion = "25.11";
}

