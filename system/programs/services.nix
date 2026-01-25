{ pkgs, ...}:

{
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

  # Remote Desktop
  #services.rustdesk-server = {
    #enable = true;
    #openFirewall = true;
  #};

  services.xrdp = {
    enable = true;
    audio.enable = true;
    #defaultWindowManager = "niri";
    openFirewall = true;
  };

  programs.wayvnc = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [ 5900 ];

  environment.systemPackages = with pkgs; [
      mpc
      sysprof
  ];
}

