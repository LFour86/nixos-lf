{pkgs, ...}:
{
  home.packages = with pkgs;[
    # Daily Applications
    bilibili-local firefox google-chrome
    imv libreoffice motrix
    mpv spotify scrcpy
    sillytavern wpsoffice-cn yazi

    # Chat
    qq wechat-uos #wemeet

    # Pitcure editor
    #gimp krita inkscape

    # OBS-Studio
    obs-studio

    # Network Proxy
    clash-rs clash-verge-rev sing-box

    # Editor
    #zed-editor

    # C/C++
    jetbrains.clion

    # STM32
    stm32cubemx

    # Arduino/ESP32
    arduino-ide
	
    # EDA
    #kicad kicadAddons.kikit

    # CAD
    #freecad
	
    # Java
    #jetbrains.idea-ultimate

    # Python
    jetbrains.pycharm-professional

    # Javascript
    #jetbrains.webstorm

    # Rust
    #jetbrains.rust-rover

    # Dotnet
    #jetbrains.rider

    # Go
    #jetbrains.goland

    # Qt
    qtcreator

    # Matlab
    octaveFull scilab-bin

    # Wine
    wineWowPackages.stable winetricks

    # Game
    melonDS mgba ppsspp
    prismlauncher
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

