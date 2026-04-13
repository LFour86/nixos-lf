{ inputs, pkgs, ... }:

let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  # KVM
  programs.virt-manager.enable = true;
  virtualisation = {
    waydroid.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
   
    # Enable Containerd
    containerd.enable = true;

    # Enable Docker
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
 
    # Enable Podman
    #podman = {
      #enable = true;
      #dockerCompat = true;
      #defaultNetwork.settings.dns_enabled = true;
    #};
  };

  environment.systemPackages = with pkgs; [
    # Docker container
    docker-client docker-compose docui
    
    # Podman Container
    dive #podman podman-tui 
    #podman-desktop podman-compose pods

    # Kubernetes
    kubernetes kubectl kubernetes-helm-wrapped
    kubernetes-validate

    # Linux to Linux
    unstable-pkgs.distrobox unstable-pkgs.distroshelf 

    # Linux to Android
    unstable-pkgs.waydroid unstable-pkgs.waydroid-helper unstable-pkgs.nftables
  ];
}

