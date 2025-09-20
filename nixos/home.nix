{ ... }:
{
  #Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.username = "lfour";
  home.homeDirectory = "/home/lfour";
  imports = [
  	./home/config.nix
	./home/llm.nix
	./home/programs.nix 
	./home/userpkgs.nix
  ];

  #Home-manager version
  home.stateVersion = "25.11";
}

