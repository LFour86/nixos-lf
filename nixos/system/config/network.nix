{ pkgs, ... }:
{
  # Enable networking
  networking.hostName = "nixos"; # Define hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  #networking.networkmanager.dns = "dnsmasq";
  #services.dnsmasq.enable = true;
  #networking.firewall.trustedInterfaces = [ "wlo1" ];

  # 可选：启用 NAT 让热点设备能上网
  networking.nat = {
      enable = true;
      externalInterface = "enp4s0";   # 外网接口（例如有线网卡或 PPPoE）
      internalInterfaces = [ "wlo1" ];  # 内部热点接口
  };

  # Substituters mirrors
  nix = {
      settings = {
        substituters = [
          "https://mirrors.ustc.edu.cn/nix-channels/store"
          "https://mirror.tuna.tsinghua.edu.cn/nix-channels/store"
          "https://cache.nixos.org"
        ];
      };
  };

  #hosts
  networking.hosts = {
    #"20.27.177.113" = ["github.com"];
  };

  environment.systemPackages = with pkgs; [];
}
