{ pkgs, ... }:

{
  programs.dconf.enable = true;
  services = {
    # Gnome
    gnome.gnome-keyring.enable = true;
    desktopManager.gnome.enable = true;
    displayManager = {
      defaultSession = "gnome";
      gdm = {
        enable = true;
        wayland = true;
      };
    };

    # KDE
    #desktopManager.plasma6.enable = true;
    #displayManager.plasma-login-manager.enable = true;
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
            #--time \
            #--remember \
            #--remember-user-session
        #'';
        #user = "greeter";
      #};
    #};
  #};

  environment.systemPackages = with pkgs; [ 
    # Gnome extensions
    gnomeExtensions.appindicator
    gnomeExtensions.astra-monitor
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dim-completed-calendar-events
    gnomeExtensions.quick-settings-audio-devices-renamer
    gnomeExtensions.user-themes
    gnomeExtensions.workspace-indicator
    # Gnome windows themes
    pkgs.adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    # Gnome extra ssettings
    gnome-tweaks
    # Applications
    #baobab
    #nautilus
    nautilus-open-any-terminal
    #gnome-software
    
    # KDE
    #kdePackages.dolphin
    #kdePackages.dolphin-plugins
    kdePackages.wallpaper-engine-plugin
    wayland-utils # Wayland utilities

    # Niri
    fuzzel
    kitty
    linux-wallpaperengine
    lswt
    mpvpaper
    nemo
    xwayland-satellite # xwayland support
    #swayidle
    #swww
    #tuigreet
    wl-clipboard
    clipman
    wlr-randr
  ];
}

