{ ... }:
{
  #Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.username = "lfour";
  home.homeDirectory = "/home/lfour";
  imports = [
  	./config.nix
	./llm.nix
	./programs.nix 
	./userpkgs.nix
  ];

  #Home-manager version
  home.stateVersion = "25.11";
}
