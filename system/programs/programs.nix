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
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraPackages = with pkgs; [
      cef-binary
      fontconfig
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      dwproton-bin
    ];
    fontPackages = with pkgs; [
      maple-mono.NF-CN
    ];
    extest.enable = true;
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
      libjpeg
      stdenv.cc.cc.lib
      udev
      wayland
      zlib
    ];
  };
}

