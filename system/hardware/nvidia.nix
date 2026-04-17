{ config, pkgs, ... }:

{
  nixpkgs.config.nvidia.acceptLicense = true;

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
 
  # Nvidia hardware settings
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    dynamicBoost.enable = true;
    powerManagement = {
      enable = true;
      finegrained = false;
    };
    open = true;
    nvidiaSettings = true;
    videoAcceleration = true;
    #prime = {
      #offload = {
        #enable = true;
        #enableOffloadCmd = true;
      #};
      # Make sure to use the correct Bus ID values for your system!
      #amdgpuBusId = "PCI:6:0:0";
      #nvidiaBusId = "PCI:1:0:0";
    #};
  };

  #hardware.nvidia-container-toolkit = {
    #enable = false;
  #};
 
  # Bootloader
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" "nvidia_uvm" ];
  
  # Fixed
  #boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  boot.blacklistedKernelModules = [ "nouveau" "amdgpu" ];
    
  # KernelParams
  boot.kernelParams = [ 
    "tsc=reliable"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "transparent_hugepage=always"
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];
    
  #Screen Tearing Issues
  #hardware.nvidia.forceFullCompositionPipeline = true;

  environment.systemPackages = with pkgs.cudaPackages; [
    # Compilation & Runtime
    cuda_nvcc        # CUDA compiler for JIT extensions
    cuda_cudart      # Core CUDA runtime library
    cuda_nvrtc       # Runtime compilation for dynamic kernels

    # Deep Learning Kernels
    libcublas        # High-performance BLAS for matrix multiplication
    cudnn            # Accelerated primitives for deep neural networks

    # Math & Development Utilities
    libcurand        # Random number generation
    libcusolver      # Numerical solver for linear systems
    cuda_nvtx        # Instrumentation for performance profiling
  ];
}

