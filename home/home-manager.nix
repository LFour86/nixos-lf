{ ... }:

{
  # Let Home-Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Users settings
  home.username = "lfour";
  home.homeDirectory = "/home/lfour";

  # Home-Manager version
  home.stateVersion = "25.11";
}

