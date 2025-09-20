{ ... }:
{   
  #Setup Env Variables
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XIM="fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  # Convenient To Compile
  environment.extraOutputsToInstall = [ "dev" ];
}
