{ pkgs, ... }:
{
  # Gnome
  dconf.settings = {
    "org/gnome/desktop/session" = {
      idle-delay = 7200;
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

  #- Desktop
  #-- Icon
  #--- Matlab
  home.file.".local/bin/matlab-launcher" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      cd "$HOME"
      exec matlab-fhs matlab "$@"
    '';
    executable = true;
  };
  xdg.desktopEntries.matlab = {
    name = "MATLAB";
    exec = "matlab-launcher";
    icon = "/home/lfour/.local/share/icons/matlab.png";
    terminal = false;
    categories = [ "Development" "Science" ];
  };

  #--- Vivado
  home.file.".local/bin/vivado-launcher" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      exec vivado-fhs "$HOME/Xilinx/Vivado/2025.1/bin/vivado" "$@"
    '';
    executable = true;
  };
  xdg.desktopEntries.vivado = {
    name = "Xilinx Vivado";
    exec = "vivado-launcher";
    icon = "/home/lfour/.local/share/icons/vivado.png";
    terminal = false;
    categories = [ "Development" "Electronics" ];
  };
}

