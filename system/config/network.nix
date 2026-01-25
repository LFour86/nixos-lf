{ pkgs, ... }:

{
  # Enable networking
  networking.hostName = "nixos"; # Define hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.resolvconf.enable = false;

  # Magic DNS on Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.resolved = {
    enable = true;
    domains = ["~."];
  };

  # Substituters mirrors
  nix = {
    settings = {
      substituters = [
        "https://mirror.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        #"https://mirror.nju.edu.cn/nix-channels/store"
        "https://mirror.iscas.ac.cn/nix-channels/store"
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
    };
  };

  #hosts
  networking.hosts = {
    #"20.27.177.113" = ["github.com"];
  };

  environment.systemPackages = with pkgs; [
    traceroute
  ];
}

