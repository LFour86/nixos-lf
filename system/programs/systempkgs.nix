{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ###############################
    cmus btop electron
    fastfetch fish ffmpeg-full
    fd file git
    git-lfs neovim networkmanager
    p7zip peazip psutils
    ripgrep-all unrar unzip
    vim wget zip
    ###############################
    exfat ntfs3g pciutils 
    procps usbutils util-linux
    ###############################
    alsa-utils bear coreutils-full
    dhcpcd direnv devenv 
    fuse glib-networking klibcShrunk
    lm_sensors lsd lshw
    lsof tree sl
    ###### C & C++ ################
    cmake gcc_multi gdb 
    gnumake llvmPackages_latest.clang-tools llvmPackages_latest.lldb
    llvmPackages_latest.libllvm llvmPackages_latest.libcxx llvmPackages_latest.clang
    ###### JAVA ##################
    jdk
    ###### Dotnet ####################
    dotnet-sdk dotnet-runtime
    ###### Embedded Development ######
    #
    gcc-arm-embedded ninja openocd
    platformio
    #
    ### STM32 ###
    #
    stm32flash stm32loader stlink
    stlink-gui stlink-tool
    #
    ### ESP32 ###
    #
    arduino-cli espflash esptool
    #
    ###### Python #################
    python314
    ###### NodeJS #################
    nodejs_24
    ###### Rust ###################
    cargo rustc
    ###### GO ####################
    go
    ###### END ###################
  ] ++ (with pkgs.kdePackages; [
    qt3d qtsvg qtdoc
    qt6ct qtmqtt qtgrpc
    qtbase qttools qtspell
    qtscxml qt6gtk2 qtspeech
    qtlottie qtgraphs qtcharts
    qtwebview qtwayland qtsensors
    qtquick3d qt5compat qtlocation
    qtkeychain qtwebengine qtutilities
    qtserialbus qtdatavis3d qtwebsockets
    qtwebchannel qtserialport qtmultimedia
    qthttpserver qtshadertools qtpositioning
    qtnetworkauth qtdeclarative qttranslations
    qtimageformats qtconnectivity qtremoteobjects
    qtquicktimeline qtquick3dphysics qtpbfimageplugin
    qtlanguageserver qtvirtualkeyboard qtquickeffectmaker
    ]);
    #
    ###### END ###################
}

