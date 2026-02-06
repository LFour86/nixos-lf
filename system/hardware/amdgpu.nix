{ lib, pkgs, config, ... }:

with lib;
let
  cfg = config.drivers.amdgpu;
in
{
  options.drivers.amdgpu = {
    enable = mkEnableOption "Enable AMD Drivers";
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    #services.xserver.videoDrivers = [ "amdgpu" ];

    # OpenGL
    hardware.graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        rocmPackages.clr.icd
        ];
    };
  };

  # GUI tools
  #environment.systemPackages = with pkgs; [ lact ];
  #systemd.packages = with pkgs; [ lact ];
  #systemd.services.lactd.wantedBy = ["multi-user.target"];
}

