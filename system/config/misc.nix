{ pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [ "root" "lfour" ];

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # GC
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.optimise = {
    automatic = true;
    dates = ["weekly"];
  };

  # Nix Index
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
  programs.command-not-found.enable = false;

  # FZF
  programs.fzf.fuzzyCompletion = true;

  time.timeZone = "Asia/Shanghai";

  services.kmscon = {
    enable = true;
    fonts = [ { name = "Maple Mono NF CN"; package = pkgs.maple-mono.NF-CN; } ];
    extraConfig = ''
      font-engine=pango
      font-size=12
    '';
  };

  # Valid font config for Chinese + English + Nerd Fonts
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      maple-mono.NF
      maple-mono.NF-CN
      nerd-fonts.jetbrains-mono
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu
      wqy_zenhei
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      font-awesome
      noto-fonts-color-emoji
      twitter-color-emoji
    ];
  };

  # Required fallback to avoid GNOME/KDE fcitx5 segmentation bugs
  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans CJK SC" "WenQuanYi Zen Hei" ];
    serif     = [ "Noto Serif CJK SC" ];
    monospace = [ "Maple Mono NF" ];
    emoji     = [ "Twitter Color Emoji" ];
  };

  # NixOS Version
  system.stateVersion = "25.11";
}

