{ config, pkgs, ... }:
{
  # Gnome
  programs.dconf.enable = true;
  services = {
    gnome.gnome-keyring.enable = true;
    #desktopManager.gnome.enable = true;
    #displayManager.gdm.enable = true;
  };
  services.udev.packages = with pkgs; [ 
    #pkgs.gnome-settings-daemon
  ];

  # Kde
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };
  # Colorful
  services.colord.enable = true;
  # Location
  services.geoclue2.enable = true;
  programs.kdeconnect.enable = true;
  # Disk
  programs.partition-manager.enable = true;
  # Indusrial I/O
  hardware.sensor.iio.enable = true;

  # Niri
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [ 
    # Gnome extensions
    #gnomeExtensions.applications-menu
    #gnomeExtensions.appindicator
    #gnomeExtensions.battery-health-charging
    #gnomeExtensions.bluetooth-battery-meter
    #gnomeExtensions.blur-my-shell
    #gnomeExtensions.caffeine
    #gnomeExtensions.clipboard-indicator
    #gnomeExtensions.dash-to-dock
    #gnomeExtensions.dim-background-windows
    #gnomeExtensions.dim-completed-calendar-events
    #gnomeExtensions.extension-list
    #gnomeExtensions.lockscreen-extension
    #gnomeExtensions.open-bar
    #gnomeExtensions.places-status-indicator
    #gnomeExtensions.quick-settings-audio-devices-renamer
    #gnomeExtensions.top-bar-organizer
    #gnomeExtensions.user-themes
    #gnomeExtensions.vitals
    #gnomeExtensions.workspace-indicator
    #gnomeExtensions.tweaks-in-system-menu
    # Gnome windows themes
    pkgs.adwaita-icon-theme
    adwaita-qt
    adwaita-qt6
    # Gnome extra ssettings
    #gnome-tweaks
    
    # KDE
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kclock
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.krdc
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    hardinfo2 # System information and benchmarks for Linux systems
    haruna # Open source video player built with Qt/QML and libmpv
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland

    # Niri
    hyprlock
    hypridle
    #nemo
    xwayland-satellite # xwayland support
    swww
    waybar
  ];
}

