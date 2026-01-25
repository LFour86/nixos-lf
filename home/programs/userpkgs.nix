{ inputs, pkgs, stdenv, ... }:

let
  unstable-pkgs = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = with pkgs;[
    # Daily Applications
    bilibili-local imv motrix
    mpv scrcpy sillytavern
    wpsoffice-cn yazi zen

    # Audio/Video Editor
    kdePackages.kdenlive kid3 shotcut

    # Chat
    qq wechat-uos #wemeet

    # Pitcure editor
    gimp krita inkscape

    # OBS-Studio
    obs-studio

    # Network Proxy
    clash-rs clash-verge-rev

    # AI Agent
    claude-code opencode zed-editor 

    # C/C++
    jetbrains.clion

    # STM32
    stm32cubemx

    # Arduino/ESP32
    arduino-ide
	
    # CAD
    freecad
	
    # Python
    jetbrains.pycharm

    # Qt
    qtcreator

    # Matlab
    octaveFull

    # Wine
    wineWowPackages.stable winetricks

    # Game
    hmcl prismlauncher

    # Others
    piper-tts

    ###### END ######

  ] ++ ( with obs-studio-plugins; [
  # Obs-Studio plugins
    #wlrobs waveform obs-tuna
    #obs-vaapi obs-teleport obs-hyperion
    #obs-websocket obs-vkcapture obs-gstreamer
    #obs-3d-effect input-overlay obs-multi-rtmp
    #obs-mute-filter obs-text-pthread obs-source-clone
    #obs-shaderfilter obs-source-record obs-replay-source
    #obs-livesplit-one obs-freeze-filter looking-glass-obs
    #obs-vintage-filter obs-scale-to-sound obs-composite-blur
    #obs-command-source obs-advanced-masks obs-source-switcher
    #obs-move-transition obs-gradient-source obs-transition-table
    #obs-backgroundremoval advanced-scene-switcher obs-pipewire-audio-capture
  ]);
}

