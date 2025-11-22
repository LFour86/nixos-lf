{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  system.stateVersion = "25.11";
}

