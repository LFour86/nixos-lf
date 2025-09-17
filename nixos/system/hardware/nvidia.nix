{ config, lib, pkgs, modulesPath, ...}:
{

  # Enable OpenGL
  hardware.graphics.enable = true;
  
   hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
    
   hardware.nvidia.prime = {
  	
  	        #offload = {
		    #enable = true;
		    #enableOffloadCmd = true;
		#};
		# Make sure to use the correct Bus ID values for your system!
		amdgpuBusId = "PCI:6:0:0";
		nvidiaBusId = "PCI:1:0:0";
	};
	
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  
  
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;
  
   #If you encounter the problem of booting to text mode you might try adding the Nvidia kernel module manually with this
   #boot.initrd.kernelModules = [ "nvidia" ];
   #boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    
    
  #disable nouveau
  boot.kernelParams = [ "modprobe.blacklist=nouveau" ];
    
   #Screen Tearing Issues
   hardware.nvidia.forceFullCompositionPipeline = true;
}

