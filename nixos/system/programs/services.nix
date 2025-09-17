{ pkgs, ...}:
{

  # Profiling (with sysprof) 
  services.sysprof.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  # Enable Hotspot
  #services.create_ap = {
    #enable = true;
    #settings = {
      #INTERNET_IFACE = "enp4s0";
      #WIFI_IFACE = "wlan0";
      #SSID = "NixOS-Linux-6.15.2";
      #PASSPHRASE = "xbwic67&*$";
    #};
  #};

  # Systemd services
  #systemd.services.wpa_supplicant.serviceConfig.TimeoutSec = "2";
  #systemd.services.NetworkManager.serviceConfig.TimeoutSec = "2";
  #systemd.services.journald.serviceConfig.TimeoutSec = "2";
  #systemd.services."udev-settle".serviceConfig.TimeoutSec = "2";
  #services.journald = {
    #storage = "persistent";
    #rateLimitBurst = 10000;
    #upload = {
    #settings = {
    #Upload = {
      #NetworkTimeoutSec = "3s";
        #};
      #};
    #};
    #extraConfig = ''
      #Storage=persistent
      #SystemMaxUse=50M
      #RuntimeMaxUse=50M
      #MaxFileSec=1week
    #'';
  #};

  services.mpd = {
    enable = true;
    user = "nixos"; 
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

  # Emacs editor
  #services.emacs.enable = true;
  #services.flatpak.enable = true;
  #systemd.services.flatpak-repo = {
  #  wantedBy = [ "multi-user.target" ];
  #  path = [ pkgs.flatpak ];
  #  script = ''
  #    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #  '';
  #};
  #environment.systemPackages = [ pkgs.flatpak-builder ];

  environment.systemPackages = with pkgs; [
      mpc-cli
      sysprof
  ];
}

