{ pkgs, ... }: {
  systemd.user.services.swayidle = {
    # these mirror the INI sections of a systemd unit file
    Unit = {
      Description = "Idle management daemon for niri";
      # Unit.* accepts string or list-of-strings
      PartOf = [ "graphical-session.target" ];
      After  = [ "graphical-session.target" ];
      BindsTo = [ "graphical-session.target" ]; # optional if you want that behavior
    };

    Service = {
      # service config lines go here (Service.ExecStart etc.)
      Restart = "always";
      ExecStart = "${pkgs.swayidle}/bin/swayidle";
      # you can add Type, WorkingDirectory, Environment, etc. if needed
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.configFile."swayidle/config".text = ''
    timeout 3600 "${pkgs.swaylock-effects}/bin/swaylock -f -C ~/.config/swaylock/config.conf --grace 10 --fade-in 5" resume "${pkgs.niri}/bin/niri msg action power-off-monitors false"
    timeout 3900 "${pkgs.niri}/bin/niri msg action power-off-monitors" resume "${pkgs.niri}/bin/niri msg action power-off-monitors false"
    before-sleep "${pkgs.swaylock-effects}/bin/swaylock -f -C ~/.config/swaylock/config.conf"
    before-sleep "${pkgs.niri}/bin/niri msg action power-off-monitors false"
  '';
}

