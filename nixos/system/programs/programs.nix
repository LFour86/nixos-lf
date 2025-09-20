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

  # Nix-ld: Run closed-source Binary
  programs.nix-ld.enable = true;
}
