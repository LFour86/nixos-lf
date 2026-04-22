{ config, pkgs, ... }:

{
    # SystemD initrd
    boot.initrd.systemd.enable = true;

    # BTRFS ephemeral root
    boot.initrd.systemd.extraBin.btrfs = "${pkgs.btrfs-progs}/bin/btrfs"; # Ensure btrfs tool is available in initrd
    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = [ "initrd.target" ];
      after = [ "systemd-cryptsetup@enc.service" ];
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
        set -euo pipefail

        mkdir -p /btrfs_tmp
        mount -o subvolid=5 /dev/mapper/enc /btrfs_tmp

        # Ensure /sysroot is not mounted before we delete the subvolume
        if mountpoint -q /sysroot 2>/dev/null; then
          echo "Warning: /sysroot is already mounted, unmounting it to avoid conflicts..."
          umount /sysroot || true
        fi

        if [[ -d /btrfs_tmp/root ]]; then
          echo "Removing existing root subvolume and all descendants recursively..."
          btrfs subvolume delete -R /btrfs_tmp/root
        fi

        echo "Creating new pristine root subvolume..."
        btrfs subvolume create /btrfs_tmp/root

        umount /btrfs_tmp
        rmdir /btrfs_tmp
    '';
  };

  # Load ntsync later to avoid race condition
  systemd.services.ntsync = {
    description = "Load ntsync kernel module after udev";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-udevd.service" "local-fs.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.kmod}/bin/modprobe ntsync";
    };
  };

  # Device node permissions (for Proton access)
  services.udev.extraRules = ''
    KERNEL=="ntsync", MODE="0666", TAG+="uaccess"
  '';

  # NVIDIA powed service
  systemd.services.nvidia-powerd = {
    after = [ "nvidia-persistenced.service" "multi-user.target" ];
    wantedBy = lib.mkForce [ "multi-user.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.bash}/bin/bash -c 'while [ ! -e /dev/nvidiactl ]; do sleep 0.5; done'";
    };
  };

  # Flatpak
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo && flatpak remote-modify flathub --url=https://mirrors.ustc.edu.cn/flathub
    '';
  };
}
