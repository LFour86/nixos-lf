{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Generic embedded
    gcc-arm-embedded
    openocd
    platformio

    # STM32
    stm32flash
    stm32loader
    stlink
    stlink-gui
    stlink-tool

    # ESP32
    espflash
    esptool
    
    # Arduino
    arduino-cli
  ];
}

