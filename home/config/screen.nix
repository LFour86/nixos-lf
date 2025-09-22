{ ... }:
{
  # Gnome
  dconf.settings = {
    "org/gnome/desktop/session" = {
      idle-delay = 1800;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };
  };

  # KDE Idle
  #xdg.configFile."powerdevilrc".text = ''
      #[AC][DPMSControl]
      #idleTime=7200000 # ms, 0 --> disable
      #sleepTime=0 # s, 0 --> disable

      #[Battery][DPMSControl]
      #idleTime=1200000 # ms
      #sleepTime=1800   # s
  #'';
}

