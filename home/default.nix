{ pkgs, inputs, ... }:

{
  #Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  home.username = "lfour";
  home.homeDirectory = "/home/lfour";

  imports = [
    inputs.noctalia-shell.homeModules.default
  	./config
	  ./programs 
  ];

  #Home-manager version
  home.stateVersion = "25.11";
}

