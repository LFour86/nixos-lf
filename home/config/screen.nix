{ lib, ... }:

let
  mkUint = lib.hm.gvariant.mkUint32;
in
{
  dconf.settings = {
    # Set the screen turn-off delay to 1 hour (3600 seconds) (plugged in)
    "org/gnome/desktop/session" = {
      idle-delay = mkUint 3600; # seconds, 0 = never
    };

    # Behavior when plugged in and on battery
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout     = mkUint 3600; # AC: 3600s -> 1 hour
      sleep-inactive-ac-type        = "nothing";   # AC: Do not suspend, 

      sleep-inactive-battery-timeout = mkUint 600; # Battery: 600s -> 10 minutes
      sleep-inactive-battery-type    = "nothing";  # Battery: just turn off the screen
    };

    # Screen Saver/Lock: Screen turns off only, does not auto-lock
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
      idle-activation-enabled = true;
    };
  };
}

