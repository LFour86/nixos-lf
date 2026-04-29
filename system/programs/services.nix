{ pkgs, ...}:

{
  # DBUS && XDG
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Logind
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "lock";
        HandleLidSwitchExternalPower = "lock";
        HandleLidSwitchDocked = "ignore";
      };
    };
  };

  # Profiling (with sysprof)
  services.sysprof.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Music Player Deamon
  services.mpd = {
    enable = true;
    user = "lfour";
    musicDirectory = "/home/lfour/Music";
    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Output"
        }
        audio_output {
          type "fifo"
          name "FIFO"
          path "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  #services.xrdp = {
    #enable = true;
    #audio.enable = true;
    #openFirewall = true;
  #};

  #programs.wayvnc = {
    #enable = true;
  #};

  
  #services.sunshine = {
    #enable = true;
    #autoStart = true;
    #capSysAdmin = true;
    #openFirewall = true;
    #settings = {
      #sunshine_name = "nixos";
      #port = 47989;
    #};
  #};

  environment.systemPackages = with pkgs; [
    mpc
    sysprof
  ];
}

