{ config, pkgs, ... }:

{
  nixpkgs.config.nvidia.acceptLicense = true;

  # Enable OpenGL
  hardware.graphics.enable = true;

  # NVIDIA Driver version
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  # NVIDIA Container
  #hardware.nvidia-container-toolkit.enable = true;

  # NVIDIA Prime
  #hardware.nvidia.prime = {
    #offload = {
      #enable = true;
      #enableOffloadCmd = true;
    #};
    # Make sure to use the correct Bus ID values for your system!
    #amdgpuBusId = "PCI:6:0:0";
    #nvidiaBusId = "PCI:1:0:0";
  #};
	
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = false;
  hardware.nvidia.powerManagement.finegrained = false;
  hardware.nvidia.open = true;
  hardware.nvidia.nvidiaSettings = true;
 
  # Bootloader
  boot.initrd.kernelModules = [ "nvidia" ];
  
  # Fixed
  #boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  boot.blacklistedKernelModules = [ "nouveau" "amdgpu" ];
    
  # KernelParams
  boot.kernelParams = [ 
    "tsc=reliable"
    "nvidia-drm.fbdev=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "transparent_hugepage=always"
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

