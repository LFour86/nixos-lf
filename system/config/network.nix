{ pkgs, ... }:

{
  # Enable networking
  networking.hostName = "nixos"; # Define hostname.
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
        "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
    };
  };

  # Nftables (FireWall)
  networking.firewall.enable = false;
  networking.nftables = {
    enable = true;
    ruleset = ''
      table inet filter {
        chain input {
          type filter hook input priority 0; policy drop;

          # LoopBack
          iif lo accept
          ct state established,related accept

          # Libvirt
          iifname "virbr0" accept

          # ICMP / ICMPv6
          ip protocol icmp accept
          ip6 nexthdr icmpv6 accept

          # DHCP client
          udp sport 67 udp dport 68 accept

          # mDNS / Avahi
          udp dport 5353 accept

          # Tailscale
          udp dport 41641 accept

          # SSH
          # tcp dport 22 accept

          # Default Reject
          reject with icmpx type admin-prohibited
        }

        chain forward {
          type filter hook forward priority 0; policy drop;

          # Libvirt
          iifname "virbr0" accept
          oifname "virbr0" ct state established,related accept
          iifname "virbr0" oifname { "enp4s0", "wlo1" } accept

          # Hotspot
          iifname "wlo1" oifname "enp4s0" accept
          iifname "enp4s0" oifname "wlo1" ct state established,related accept

          # Default Reject
          reject with icmpx type admin-prohibited
        }

        chain output {
          type filter hook output priority 0; policy accept;
        }
      }

      # NAT
      table ip nat {
        chain postrouting {
          type nat hook postrouting priority 100;
          oifname "enp4s0" ip saddr 192.168.122.0/24 masquerade
          oifname "wlo1"  ip saddr 192.168.122.0/24 masquerade
         oifname "enp4s0" masquerade   # hotspot clients
        }
      }
    '';
  };

  # Fail2ban: intended for exposed SSH / servers
  services.fail2ban.enable = false;

  # Avahi / mDNS (local discovery)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  #hosts
  #networking.hosts = {
    #"20.27.177.113" = ["github.com"];
  #};

  environment.systemPackages = with pkgs; [
    traceroute
  ];
}

