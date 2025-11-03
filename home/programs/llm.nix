{ pkgs, ... }:
{
  #services.llama-cpp = {
    #enable = false;
    #extraFlags = [
      #"-c"
      #"4096"
      #"-ngl"
      #"32"
      #"--numa"
      #"numactl"
    #];
  #};

  services.ollama = {
    enable = false;
    acceleration = "cuda";
  };

  home.packages = with pkgs; [
    ollama
    llama-cpp
  ];
}
