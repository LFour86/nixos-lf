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
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;
 
  # Bootloader
  boot.initrd.kernelModules = [ "nvidia" ];
  
  # Fixed
  #boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  boot.blacklistedKernelModules = [ "nouveau" "amdgpu" ];
    
  # KernelParams
  boot.kernelParams = [ 
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1" 
    "tsc=reliable"
  ];
    
  #Screen Tearing Issues
  hardware.nvidia.forceFullCompositionPipeline = true;

  environment.systemPackages = with pkgs.cudaPackages; [
    # ---- Core CUDA Toolkit ----
    cudatoolkit cuda_cccl cuda_cudart
    cuda_nvcc cuda_nvrtc cuda_nvprune
    # ---- cuDNN / High-Perf Math Libraries ----
    cudnn #cudnn-frontend
    libcublas
    #libcublasmp 
    #libcudss libcusparse
    #libcusparse_lt libcusolver libcusolvermp
    #libcutensor libcurand libcufft
    # ---- Image / Video / NPP ----
    #libnpp libnpp_plus libnvjpeg
    #libnvjpeg_2k libnvtiff libnvjitlink
    #libnvfatbin
    # ---- Communication / Distributed ----
    #nccl nccl-tests libnvshmem
    #gdrcopy fabricmanager
    # ---- Quantum / Numerical ----
    #cuquantum cutlass imex
    # ---- Debug / Sanitizers / Profilers ----
    #cuda_gdb cuda_nvprof cuda_nvtx
    #cuda_profiler_api cuda_sanitizer_api cuda_opencl
    # ---- Nsight Tools ----
    #nsight_systems nsight_compute cuda_nsight
    #cuda_nvvp
    # ---- Diagnostics / Utils ----
    #cuda_documentation cuda_demo_suite #cuda-samples
    #cuda_cupti cuda_cuobjdump cuda_nvdisasm
    #cuda_nvml_dev cuda_cuxxfilt
    # ---- TensorRT / Misc ----
    #tensorrt nvcomp
  ];
}

