{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [ "root" "lfour" ];

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Auto Upgrade
  system.autoUpgrade = {
    enable = true;
    flake = "/etc/nixos#lfour";
    dates = "08:00";
    allowReboot = true;
  };

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
      #noto-fonts-color-emoji
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

  # Fcitx5
  #fonts.fontconfig.conf = pkgs.makeFontsConf {
    #name = "emoji-fallback";
    #extraFonts = [ pkgs.twitter-color-emoji ];
  #};

  system.stateVersion = "26.05";
}

