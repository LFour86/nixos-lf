{ pkgs, ... }:

{
  programs.dconf.enable = true;
  services = {
    # Gnome
    gnome.gnome-keyring.enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      defaultSession = "niri";
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    # KDE
    desktopManager.plasma6.enable = true;
    #displayManager.sddm.enable = true
    #displayManager.sddm.wayland.enable = true;
  };
  
  services.udev.packages = with pkgs; [ 
    pkgs.gnome-settings-daemon
  ];

  # Colord
  services.colord.enable = true;
  # Indusrial I/O
  hardware.sensor.iio.enable = true;

  # Niri
  programs.niri.enable = true;
  programs.xwayland.enable = true;
  #services.greetd = {
    #enable = true;
    #settings = {
      #default_session = {
        #command = ''
          #${pkgs.tuigreet}/bin/tuigreet \
           # --time \
           # --remember \
           # --remember-user-session
        #'';
        #user = "greeter";
      #};
    #};
  #};

  environment.systemPackages = with pkgs; [ 
    # Gnome extensions
    gnomeExtensions.appindicator
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dim-completed-calendar-events
    gnomeExtensions.open-bar
    gnomeExtensions.quick-settings-audio-devices-renamer
    gnomeExtensions.top-bar-organizer
    gnomeExtensions.user-themes
    gnomeExtensions.vitals
    gnomeExtensions.workspace-indicator
    gnomeExtensions.tweaks-in-system-menu
    # Gnome windows themes
    pkgs.adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    # Gnome extra ssettings
    gnome-tweaks
    # Applications
    #baobab
    #nautilus
    #gnome-software
    
    # KDE
    #kdePackages.dolphin
    #kdePackages.dolphin-plugins
    wayland-utils # Wayland utilities

    # Niri
    fuzzel
    gedit
    kitty
    linux-wallpaperengine
    mpvpaper
    xwayland-satellite # xwayland support
    swaylock-effects
    swayidle
    swww
    #xfce.thunar
    tuigreet
    waybar
    wl-clipboard
    clipman
    wlr-randr
  ];
}

