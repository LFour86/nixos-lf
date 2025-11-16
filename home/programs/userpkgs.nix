{pkgs, ...}:
{
  home.packages = with pkgs;[
    # Daily Applications
    bilibili-local
    firefox
    google-chrome
    libreoffice
    motrix
    spotify
    scrcpy
    sillytavern
    wpsoffice-cn

    # Chat
    qq
    wechat-uos
    wemeet

    # Pitcure editor
    gimp
    krita
    inkscape

    # Ventoy
    #ventoy-full
    #ventoy-full-qt

    # OBS-Studio
    obs-studio
    obs-studio-plugins.wlrobs
    obs-studio-plugins.waveform
    obs-studio-plugins.obs-tuna
    obs-studio-plugins.obs-vaapi
    obs-studio-plugins.obs-teleport
    obs-studio-plugins.obs-hyperion
    obs-studio-plugins.obs-websocket
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-gstreamer
    obs-studio-plugins.obs-3d-effect
    obs-studio-plugins.input-overlay
    obs-studio-plugins.obs-multi-rtmp
    obs-studio-plugins.obs-mute-filter
    obs-studio-plugins.obs-text-pthread
    obs-studio-plugins.obs-source-clone
    obs-studio-plugins.obs-shaderfilter
    obs-studio-plugins.obs-source-record
    obs-studio-plugins.obs-replay-source
    obs-studio-plugins.obs-livesplit-one
    obs-studio-plugins.obs-freeze-filter
    obs-studio-plugins.looking-glass-obs
    obs-studio-plugins.obs-vintage-filter
    obs-studio-plugins.obs-scale-to-sound
    obs-studio-plugins.obs-composite-blur
    obs-studio-plugins.obs-command-source
    obs-studio-plugins.obs-advanced-masks
    obs-studio-plugins.obs-source-switcher
    obs-studio-plugins.obs-move-transition
    obs-studio-plugins.obs-gradient-source
    obs-studio-plugins.obs-transition-table
    obs-studio-plugins.obs-backgroundremoval
    obs-studio-plugins.advanced-scene-switcher
    obs-studio-plugins.obs-pipewire-audio-capture

    # Network Proxy
    clash-rs
    clash-verge-rev
    sing-box

    # Editor
    #zed-editor

    # C/C++
    jetbrains.clion

    # STM32
    stm32cubemx

    # Arduino/ESP32
    arduino-ide
	
    # EDA
    kicad
    kicadAddons.kikit

    # CAD
    freecad
	
    # Java
    jetbrains.idea-ultimate

    # Python
    jetbrains.pycharm-professional

    # Javascript
    jetbrains.webstorm

    # Rust
    jetbrains.rust-rover

    # Dotnet
    jetbrains.rider

    # Go
    jetbrains.goland

    # Qt
    qtcreator

    # Matlab
    octaveFull
    scilab-bin

    # Game
    melonDS
    mgba
    ppsspp
    prismlauncher
  ];
}

