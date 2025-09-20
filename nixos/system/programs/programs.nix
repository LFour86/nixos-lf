{ pkgs, ... }: 
{
  # Enable Java
  programs.java.enable = true;
  
  # Enable Direnv
  #programs.direnv.enable = true;

  # Enable Steam
  programs.steam.enable = true;

  # Enable zsh
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  # Neovim
  environment.variables.EDITOR = "nvim";
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # Emacs-Unstable 
  #services.emacs.enable = true;
  #services.emacs.package = pkgs.emacs-unstable;
  #nixpkgs.overlays = [
  #  (import (builtins.fetchTarball {
  #    url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
  #    sha256 = "0ad9qjz1y1n2hy69ixl1mbzd0mn19070765v5gdp3b19pggsii4w";
  #  }))
  #];

  # Nix ld 
  #programs.nix-ld.enable = true;
}
