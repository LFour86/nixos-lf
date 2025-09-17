{ pkgs, ... }: 
{
  # Enable Java
  programs.java.enable = true;
  
  # Enable Direnv
  programs.direnv.enable = true;

  # Enable Steam
  programs.steam.enable = true;

  # Enable fish
  programs.fish = {
    enable = true;
    shellAliases = {
      li = "lsd --human-readable --all";
      tt = "tree";
      update = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#lfour";
      garbage = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      flake = "cd /etc/nixos && sudo nix flake update";
    };
  };

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
  programs.nix-ld.enable = true;
}

