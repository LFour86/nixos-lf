{ pkgs, ... }:

{
  # Base Policy
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Explicitly trust system CA bundle
  security.pki.certificates = [
    (builtins.readFile "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt")
  ];
  # Force Nix to use the system CA bundle
  nix.settings.ssl-cert-file = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";

  #Tailscale
  services.tailscale.enable = true;

  # AppArmor
  security.apparmor = {
    enable = true;
    packages = with pkgs; [
      apparmor-utils
      apparmor-profiles
    ];
  };

  # Polkit
  security.polkit.enable = true;

  # Nftables
  networking.nftables = {
    enable = true;
    ruleset = ''
      table inet filter {
        chain input {
          type filter hook input priority 0;

          # Allow local loopback
          iif lo accept

          # Allow established / related connections
          ct state established,related accept

          # Allow ICMP / ICMPv6 (ping, IPv6 functionality)
          ip protocol icmp accept
          ip6 nexthdr icmpv6 accept

          # Allow DHCP (client/server)
          udp sport 67-68 accept
          udp dport 67-68 accept

          # Allow mDNS / Avahi (desktop service discovery)
          udp dport 5353 accept

	        # Allow hotspot forwarding (Wi-Fi → uplink)
          iifname "wlo1" oifname "enp4s0" accept
          iifname "enp4s0" oifname "wlo1" ct state established,related accept

          # Allow SSH (enable only if needed)
          # tcp dport 22 accept

          # Default deny
          reject with icmpx type admin-prohibited
        }

        chain forward {
          type filter hook forward priority 0;

          # Allow outbound forwarding from libvirt virtual network
          iifname "virbr0" oifname "enp4s0" accept
          iifname "virbr0" oifname "wlo1" accept

          # Allow related / established forwarding
          ct state established,related accept

          # Hostpot
          iifname "wlo1" oifname "enp4s0" accept
          iifname "enp4s0" oifname "wlo1" ct state established,related accept

          # Default deny
          reject with icmpx type admin-prohibited
        }

        chain output {
          type filter hook output priority 0;

          # Allow all outbound traffic
          accept
        }
      }

      table ip nat {
        chain postrouting {
          type nat hook postrouting priority 100;

          # NAT masquerade for libvirt VMs (wired interface)
          oifname "enp4s0" ip saddr 192.168.122.0/24 masquerade

          # NAT masquerade for libvirt VMs (Wi-Fi interface)
          oifname "wlo1" ip saddr 192.168.122.0/24 masquerade

          # NAT for hotspot clients
          oifname "enp4s0" masquerade
        }
      }
    '';
  };

  # Kernel Sysctl
  boot.kernel.sysctl = {
    # Restrict kernel pointer exposure (non-root)
    "kernel.kptr_restrict" = 1;

    # Allow dmesg access (required for GPU / DRM debugging)
    "kernel.dmesg_restrict" = 0;

    # Disable core dumps for setuid binaries
    "fs.suid_dumpable" = 0;

    # Network layer hardening
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.ip_forward" = 1;
  };

  # PAM Hardening
  security.pam.loginLimits = [
    { domain = "*"; item = "maxlogins"; type = "hard"; value = "10"; }
  ];

  # OOM Protection
  systemd.oomd.enable = true;

  # Firmware Updates
  services.fwupd.enable = true;

  # CUPS printing
  services.printing.enable = true;

  # Avahi / mDNS (local discovery)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Removable media / desktop integration
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # Fail2ban: intended for exposed SSH / servers
  services.fail2ban.enable = false;

  # Auditd: noisy and unnecessary for desktop usage
  security.auditd.enable = false;

  # Disk Encryption
  #boot.initrd.luks.devices."luks-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx".device = "/dev/disk/by-uuid/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
  
  environment.systemPackages = with pkgs; [
    # CA / TLS
    cacert
  ];
}

