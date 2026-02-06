{ ... }: 

{
  # Enable Java
  programs.java.enable = true;
  
  # Enable Direnv
  programs.direnv.enable = true;

  # Enable Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Enable fish
  # Enable fish
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "lsd --human-readable --all";
      tt = "tree";
      update = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#lfour";
      garbage = "sudo nix-collect-garbage --delete-older-than 3d && nix-collect-garbage --delete-older-than 3d";
      flake = "cd /etc/nixos && sudo nix flake update";
      fix = "sudo nix-store --verify --check-contents --repair";
    };
  };

  # Neovim
  environment.variables.EDITOR = "nvim";

  # Nix-ld: Run closed-source Binary
  programs.nix-ld.enable = true;
}

