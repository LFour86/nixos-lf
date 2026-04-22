{pkgs, ...}:

{
  # File system
  fileSystems."/" = { options = [ "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };
  fileSystems."/home" = { options = [ "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };
  fileSystems."/persist" = {
    options = [ "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ];
    neededForBoot = true;
  };
  fileSystems."/var/lib/flatpak" = { options = [ "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };
  fileSystems."/nix" = { options = [ "compress=zstd:3" "noatime" "discard=async" "space_cache=v2" "ssd" "commit=120" ]; };

  # swap
  swapDevices = [ { device = "/dev/mapper/enc-swap"; } ];

  # impermanence
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      #"/var/lib"  # suggested subdirectory breakdown
      "/var/lib/bluetooth"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/random-seed"
      "/var/lib/libvirt"
      "/var/lib/docker"

      "/etc/NetworkManager/system-connections"

      # If use SSH
      # "/etc/ssh"
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

  environment.systemPackages = with pkgs; [
    btrfs-progs disko tpm2-tools
  ];
}
