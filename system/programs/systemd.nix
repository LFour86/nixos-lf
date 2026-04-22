{ config, pkgs, ... }:

{
    # SystemD initrd
    boot.initrd.systemd.enable = true;

    # BTRFS ephemeral root
    boot.initrd.systemd.extraBin.btrfs = "${pkgs.btrfs-progs}/bin/btrfs"; # Ensure btrfs tool is available in initrd
    boot.initrd.systemd.services.rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = [ "initrd.target" ];
      after = [ "systemd-cryptsetup@enc.service" ]; # Run after LUKS partition is decrypted
      before = [ "sysroot.mount" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      script = ''
        set -euo pipefail

        # Create a temporary mount point
        mkdir -p /btrfs_tmp

        # Mount the BTRFS root (subvolid=5) to access all subvolumes
        mount -o subvolid=5 /dev/mapper/enc /btrfs_tmp

        # Check if the root subvolume exists
        if [[ -d /btrfs_tmp/root ]]; then
          echo "Cleaning up existing root subvolume and its children..."

          # List all subvolumes under /root, extract paths, sort in reverse order (deepest first)
          # and delete them one by one to avoid "directory not empty" errors
          btrfs subvolume list -o /btrfs_tmp/root | awk '{print $NF}' | sort -r | while read -r subvolume; do
            echo "Deleting nested subvolume: $subvolume"
            btrfs subvolume delete "/btrfs_tmp/$subvolume"
          done

          # Finally delete the root subvolume itself
          echo "Deleting /root subvolume..."
          btrfs subvolume delete /btrfs_tmp/root
        fi

        # Create a new, empty root subvolume for a fresh boot
        echo "Creating new pristine root subvolume..."
        btrfs subvolume create /btrfs_tmp/root

        # Clean up: unmount and remove the temporary directory
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
