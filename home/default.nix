{ ... }:
{
  #Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.username = "lfour";
  home.homeDirectory = "/home/lfour";
  imports = [
  	./config
	./programs 
  ];

  #Home-manager version
  home.stateVersion = "26.05";
}

