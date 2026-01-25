{ pkgs, ... }:

{
  # KVM
  programs.virt-manager.enable = true;
  virtualisation = {
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
    #docker = {
      #enable = true;
      #rootless = {
        #enable = true;
        #setSocketVariable = true;
      #};
    #};
 
    # Enable Podman
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Docker container
    #docker-client docker-compose docui
    
    # Podman Container
    dive podman podman-tui 
    podman-desktop podman-compose pods

    # Kubernetes
    kubernetes kubectl kubernetes-helm-wrapped
    kubernetes-validate

    # Linux to Linux
    distrobox distroshelf

    # Linux to Windows
    #winboat

    # Linux to Android
    waydroid waydroid-helper waydroid-nftables
  ];
}

