{ pkgs, ... }:
{
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Chniese inputMethod
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
	fcitx5-rime
	fcitx5-nord
	fcitx5-gtk
	libpinyin
	kdePackages.fcitx5-qt
	kdePackages.fcitx5-unikey
	kdePackages.fcitx5-skk-qt
	kdePackages.fcitx5-configtool
	kdePackages.fcitx5-with-addons
        kdePackages.fcitx5-chinese-addons
	fcitx5-pinyin-moegirl
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    #kdePackages.fcitx5-chinese-addons
  ];
}
