{ config, lib, pkgs, modulesPath, ...}:
{
  # Enable OpenGL
  hardware.graphics.enable = true;

  # NVIDIA Driver version
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;

  # NVIDIA Container
  hardware.nvidia-container-toolkit.enable = true;

  # NVIDIA Prime
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
 
  # Bootloader
  boot.initrd.kernelModules = [ "nvidia" ];
  
  # Fixed
  #boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    
  #Disable nouveau
  boot.kernelParams = [ "modprobe.blacklist=nouveau" "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    
  #Screen Tearing Issues
  hardware.nvidia.forceFullCompositionPipeline = true;

  environment.systemPackages = with pkgs; [
    cudaPackages.tensorrt
    cudaPackages.nvcomp
    cudaPackages.nsight_systems
    cudaPackages.nsight_compute
    cudaPackages.nccl-tests
    cudaPackages.nccl
    cudaPackages.libnvtiff
    cudaPackages.libnvshmem
    cudaPackages.libnvjpeg_2k
    cudaPackages.libnvjpeg
    cudaPackages.libnvjitlink
    cudaPackages.libnvfatbin
    cudaPackages.libnpp_plus
    cudaPackages.libnpp
    cudaPackages.libcutensor
    cudaPackages.libcusparse_lt
    cudaPackages.libcusparse
    cudaPackages.libcusolvermp
    cudaPackages.libcusolver
    cudaPackages.libcurand
    cudaPackages.libcufile
    cudaPackages.libcufft
    cudaPackages.libcudss
    cudaPackages.libcublasmp
    cudaPackages.libcublas
    cudaPackages.imex
    cudaPackages.gdrcopy
    cudaPackages.fabricmanager
    cudaPackages.cutlass
    cudaPackages.cuquantum
    cudaPackages.cudnn-frontend
    cudaPackages.cudnn
    cudaPackages.cudatoolkit
    cudaPackages.cuda_sanitizer_api
    cudaPackages.cuda_profiler_api
    cudaPackages.cuda_opencl
    cudaPackages.cuda_nvvp
    cudaPackages.cuda_nvtx
    cudaPackages.cuda_nvrtc
    cudaPackages.cuda_nvprune
    cudaPackages.cuda_nvprof
    cudaPackages.cuda_nvml_dev
    cudaPackages.cuda_nvdisasm
    cudaPackages.cuda_nvcc
    cudaPackages.cuda_nsight
    cudaPackages.cuda_gdb
    cudaPackages.cuda_documentation
    cudaPackages.cuda_demo_suite
    cudaPackages.cuda_cuxxfilt
    cudaPackages.cuda_cupti
    cudaPackages.cuda_cuobjdump
    cudaPackages.cuda_cudart
    cudaPackages.cuda_cccl
    cudaPackages.cuda-samples
  ];
}
