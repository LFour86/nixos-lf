{ ... }:
{
  environment.variables = {
    # Enable Wayland for Electron/Chromium apps
    NIXOS_OZONE_WL = "1";

    # Fix cursor glitches on some GPUs (Wayland)
    WLR_NO_HARDWARE_CURSORS = "1";

    # Fcitx5 variables — Wayland-safe
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XIM="fcitx";
    XMODIFIERS = "@im=fcitx";
    GLFW_IM_MODULE = "fcitx";   # For games/tools using GLFW
    SDL_IM_MODULE = "fcitx";    # For SDL apps (games)
  };

  environment.extraOutputsToInstall = [ "dev" ];
}

