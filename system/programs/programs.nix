{ pkgs, ... }: 

{
  # Enable Java
  programs.java.enable = true;
  
  # Enable Direnv
  programs.direnv.enable = true;

  
  # Nix Index
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
  programs.command-not-found.enable = false;

  # FZF
  programs.fzf.fuzzyCompletion = true;

  # Gamemode
  programs.gamemode.enable = true;

  # Gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # Appimage
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };
  hardware.steam-hardware.enable = true;

  # Neovim
  environment.variables.EDITOR = "nvim";

  # Nix-ld: Run closed-source Binary
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      gcc
      llvm
      stdenv.cc.cc.lib
      udev
      wayland
    ];
  };
}

