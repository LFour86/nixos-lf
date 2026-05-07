{pkgs, ...}:

{
  # File system
  fileSystems."/" = { options = [ "subvol=root" "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };
  fileSystems."/home" = { options = [ "subvol=home" "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };
  fileSystems."/persist" = {
    options = [ "subvol=persist" "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ];
    neededForBoot = true;
  };
  fileSystems."/var/lib/flatpak" = { options = [ "subvol=flatpak" "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };
  fileSystems."/nix" = { options = [ "subvol=nix" "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };

  # swap
  swapDevices = [ { device = "/dev/mapper/enc-swap"; } ];

  # impermanence
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      # suggested subdirectory breakdown
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"

      # If use SSH
      #"/etc/ssh"

      "/var/lib/bluetooth"
      "/var/lib/containerd"
      "/var/lib/containers"
      "/var/lib/docker"
      "/var/lib/libvirt"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
      "/var/lib/systemd/backlight"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/linger"
      "/var/lib/systemd/random-seed"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"

      # If use SSH
      # "/etc/ssh/ssh_host_rsa_key"
      # "/etc/ssh/ssh_host_ed25519_key"
    ];
  };

  boot.kernelParams = [
    "dm_mod.dm_mq_queue_depth=2048"
  ];

  boot.initrd.availableKernelModules = [ "tpm" "tpm_tis" "tpm_crb" ];
    
  boot.initrd.systemd.extraBin = {
    cryptsetup = "${pkgs.cryptsetup}/bin/cryptsetup";
    tpm2_pcrread = "${pkgs.tpm2-tools}/bin/tpm2_pcrread";
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs disko tpm2-tools
  ];
}

