{ pkgs, ... }:

{
  # Enable networking
  networking.hostName = "nixos"; # Define hostname.
  networking.networkmanager.enable = true;
  networking.resolvconf.enable = false;

  # BCC
  programs.bcc.enable = true;

  # Magic DNS on Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  services.resolved = {
    enable = true;
    domains = ["~."];
    extraConfig = ''
      DNSStubListenerExtra=udp:0.0.0.0:53
    '';
  };

  # Substituters mirrors
  nix = {
    settings = {
      substituters = [
        #"https://mirror.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
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

            # Loopback interface
            iif lo accept

            # Established and related connections
            ct state established,related accept

            # ICMP / ICMPv6
            ip protocol icmp accept
            ip6 nexthdr icmpv6 accept

            # DHCP server (required for hotspot)
            udp dport 67 accept

            # DNS server (required by hotspot clients)
            udp dport 53 accept
            tcp dport 53 accept

            # mDNS / Avahi
            udp dport 5353 accept

            # Tailscale
            udp dport 41641 accept

            # Remote desktop protocols
            tcp dport { 3389, 5900, 47989 } accept        # RDP, VNC, Sunshine WebUI
            udp dport { 47998, 47999, 48000, 48010 } accept # Sunshine streaming ports

            # SSH (uncomment if needed)
            # tcp dport 22 accept

            # Libvirt
            iifname "virbr0" accept

            # Default reject
            reject with icmpx type admin-prohibited
        }

        chain forward {
          type filter hook forward priority 0; policy drop;

          # Hotspot
          iifname "wlo1" ip saddr 10.42.0.0/24 accept
          oifname "wlo1" ip daddr 10.42.0.0/24 ct state established,related accept

          # Libvirt
          iifname "virbr0" accept
          oifname "virbr0" ct state established,related accept
          iifname "virbr0" oifname { "enp4s0", "wlo1" } accept

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

