{ pkgs, ... }: 
{
  # Enable Java
  programs.java.enable = true;
  
  # Enable Direnv
  programs.direnv.enable = true;

  # Enable Steam
  programs.steam.enable = true;

  # Enable fish
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;

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
