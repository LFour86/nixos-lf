{ pkgs, ... }:
{
  # KVM
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
     qemu = {
       package = pkgs.qemu_kvm;
       runAsRoot = true;
       swtpm.enable = true;
       vhostUserPackages = [ pkgs.virtiofsd ];
    };
   };
   
  # Enable Containerd
  virtualisation.containerd.enable = true;

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    docui
  ];
}

