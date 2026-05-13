{ pkgs, ... }:

{
  # Nix settings 
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "lfour" ];
    auto-optimise-store = true;
  };

  # Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # GC
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  # Systemd service: optimise
  nix.optimise = {
    automatic = true;
    dates = ["daily"];
  };

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

  environment.systemPackages = with pkgs; [
    nh
  ];
}

