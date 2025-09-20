{ lib, pkgs, ... }:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.segger-jlink.acceptLicense = true;

  # Enable nftables
  networking.nftables = {
  enable = true;
  ruleset = ''
        table inet filter {
          chain input {
            type filter hook input priority 0;

            # Allow Local Loopback
            iif lo accept

            # Allow Established/Related Connections
            ct state established,related accept

            # Allow ICMP (Ping / IPv6 Required)
            ip protocol icmp accept
            ip6 nexthdr icmpv6 accept

            # Allow DHCP (Client Request & Server Response)
            udp dport 67-68 accept
            udp sport 67-68 accept

            # Allow mDNS / Avahi / Bluetooth Network Discovery
            udp dport 5353 accept

            # Allow SSH
            # tcp dport 22 accept

            # Default Rejection
            reject with icmpx type admin-prohibited
          }

          chain forward {
            type filter hook forward priority 0;

            # Allow Hotspot NAT Forwarding (Wireless → Wired)
            ct state established,related accept
            iifname "wlo1" oifname "enp4s0" accept
            oifname "wlo1" iifname "enp4s0" accept

            # Default Rejection
            reject with icmpx type admin-prohibited
          }

          chain output {
            type filter hook output priority 0;
            accept
          }
      }

      table ip nat {
        chain postrouting {
          type nat hook postrouting priority 100;

          # Perform Source Address Spoofing on Hotspot Traffic.
          oifname "enp4s0" masquerade
  	}
      }
    '';
  };

  # Enable Security Services
  security.apparmor = {
    enable = true;
    packages = with pkgs; [
      apparmor-utils
      apparmor-profiles
    ];
  };
  # Gnome Desktop
  security.polkit.enable = true;
  
  # Clamav: Windows File Share Protection
  services.clamav = {
    scanner.enable = true;
    daemon.enable = true;
    updater.enable = true;
  };
  
  # SSH Protections
  services.fail2ban.enable = true;

  # Prevent Memory Explosion
  systemd.oomd.enable = true;
  
  # Enable Auditd (System Audit Log)
  security.auditd.enable = true;

  # Automatically Update Security Patches
  #system.autoUpgrade = {
    #enable = true;
    #flake = "/etc/nixos";
    #flags = [ "--update-input" "nixpkgs" "-L" ];
    #dates = "daily";
  #};

  # Enable Hardware Update
  services.fwupd.enable = true;

  # Hardened Kernel Parameters (Sysctl)
  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;    # Hide kernel pointers to prevent information leakage
    "kernel.dmesg_restrict" = 1;    # Restrict non-root users from viewing dmesg
    "fs.suid_dumpable" = 0;    # Disable suid programs from generating core dumps
    "kernel.unprivileged_bpf_disabled" = 1;    # Disable non-root users from using BPF to avoid privilege escalation vulnerabilities

    # Network layer security
    "net.ipv4.conf.all.rp_filter" = 1;    # Enable reverse path filtering to prevent IP spoofing
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;    # Disable accepting ICMP redirects
    "net.ipv4.conf.all.send_redirects" = 0;    # Disable sending ICMP redirects
    "net.ipv6.conf.all.accept_redirects" = 0;    # Disable IPv6 redirection
  };

  # Enable PAM Hardening
  security.pam.loginLimits = [
    { domain = "*"; item = "maxlogins"; type = "hard"; value = "3"; }
  ];
  
  # Crypto Swap
  #boot.initrd.luks.devices."swap" = {
    #device = "/dev/nvme1n1p3";
    #keyFile = "/dev/urandom";
    #allowDiscards = true;
  #};

  # Enable CUPS to Print Documents.
  services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
   };

  # USB Automounting
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # Enable USB Guard
  services.usbguard = {
    enable = true;
    dbus.enable = true;
    implicitPolicyTarget = "block";
    # TODO set yours pref USB devices (change {id} to your trusted USB device),
    #use "lsusb" command (from usbutils package) to get list of all connected USB devices
    #including integrated devices like camera, bluetooth, wifi, etc.
    #with their IDs or just disable `usbguard`
    rules = ''
          allow id 1d6b:0002 # Linux Foundation 2.0 root hub
          allow id 1d6b:0003 # Linux Foundation 3.0 root hub
          allow id 0bda:5411 # Realtek Semiconductor Corp. RTS5411 hub
          allow id 5986:118a # Bison Electronics Inc. Integrated Camera
          allow id 30fa:1701 # INSTANT USB GAMING MOUSE
	  allow id 05e3:0610 # Genesys Logic, Inc. Hub
          allow id 048d:c102 # Integrated Technology Express, Inc. ITE Device(8910)
          allow id 0489:e0cd # Foxconn / Hon Hai MediaTek Bluetooth Adapter
          allow id 1d6b:0003 # Linux Foundation 3.0 root hub
          allow id 0bda:0411 # Realtek Semiconductor Corp. Hub
	  allow id 0bda:9201 # Realtek Semiconductor Corp. Ugreen Storage Device
          allow id 258a:013b # Sino Wealth USB Keyboard
	  allow id 0483:572a # STMicroelectronics STM32F401 microcontroller [ARM Cortex M4] [CDC/ACM serial port]
          allow id 24a9:205a # ASolid USB
          allow id 1908:0226 # GEMBIRD MicroSD Card Reader/Writer
	  allow id 1ea7:0064 # SHARKOON Technologies GmbH 2.4GHz Wireless rechargeable vertical mouse [More&Better]
    '';
  };

  environment.systemPackages = with pkgs; [];
}
