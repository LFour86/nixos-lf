{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  home.packages = with pkgs; [
    llama-cpp
    lmstudio
  ];
}

