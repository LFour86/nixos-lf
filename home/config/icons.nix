{ pkgs, ... }:
{
  #- Icon
  #-- Matlab
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

  #-- Vivado
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
