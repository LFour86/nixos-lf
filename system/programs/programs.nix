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
      garbage = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
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

  # Nix-ld: Run closed-source Binary
  programs.nix-ld.enable = true;
}

