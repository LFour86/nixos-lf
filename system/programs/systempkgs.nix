{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ###############################
    btop
    fastfetch
    fish
    git
    neovim
    unrar
    unzip
    vim
    wget
    electron
    ffmpeg-full
    networkmanager
    ###############################
    blueman
    bluez
    bluez-tools
    exfat
    ntfs3g
    ###############################
    alsa-utils
    bear
    coreutils-full
    dhcpcd
    direnv
    fuse
    glib-networking
    klibcShrunk
    lsd
    lshw
    lsof
    pciutils
    tree
    sl
    usbutils
    ###### C & C++ ################
    # Default
    cmake
    gcc_multi 
    gdb 
    gnumake
    llvmPackages_latest.clang-tools
    llvmPackages_latest.lldb
    llvmPackages_latest.libllvm
    llvmPackages_latest.libcxx
    llvmPackages_latest.clang
    # Qt
    kdePackages.qt3d
    kdePackages.qtsvg
    kdePackages.qtdoc
    kdePackages.qt6ct
    kdePackages.qtmqtt
    kdePackages.qtgrpc
    kdePackages.qtbase
    kdePackages.qttools
    kdePackages.qtspell
    kdePackages.qtscxml
    kdePackages.qt6gtk2
    kdePackages.qtspeech
    kdePackages.qtlottie
    kdePackages.qtgraphs
    kdePackages.qtcharts
    kdePackages.qtwebview
    kdePackages.qtwayland
    kdePackages.qtsensors
    kdePackages.qtquick3d
    kdePackages.qt5compat
    kdePackages.qtlocation
    kdePackages.qtkeychain
    kdePackages.qtwebengine
    kdePackages.qtutilities
    kdePackages.qtserialbus
    kdePackages.qtdatavis3d
    kdePackages.qtwebsockets
    kdePackages.qtwebchannel
    kdePackages.qtserialport
    kdePackages.qtmultimedia
    kdePackages.qthttpserver
    kdePackages.qtshadertools
    kdePackages.qtpositioning
    kdePackages.qtnetworkauth
    kdePackages.qtdeclarative
    kdePackages.qttranslations
    kdePackages.qtimageformats
    kdePackages.qtconnectivity
    kdePackages.qtremoteobjects
    kdePackages.qtquicktimeline
    kdePackages.qtquick3dphysics
    kdePackages.qtpbfimageplugin
    kdePackages.qtlanguageserver
    kdePackages.qtvirtualkeyboard
    kdePackages.qtquickeffectmaker
    #
    ###### JAVA ##################
    jre21_minimal
    zulu24
    jre8
    ###### Embedded Development ######
    #
    arduino-cli 
    dotnet-sdk
    dotnet-runtime
    gcc-arm-embedded
    ninja
    openocd
    platformio
    #
    ### STM32 ###
    #
    stm32flash
    stm32loader
    stlink
    stlink-gui
    stlink-tool
    #
    ### ESP32 ###
    #
    espflash
    esptool
    #
    ###### Python #################
    python313
    python313Packages.openai-whisper
    python313Packages.torch
    python313Packages.sounddevice
    ###### NodeJS #################
    nodejs
    ###### Rust ###################
    cargo
    rustc
    ###### GO ####################
    go
    ###### Others ################
    # Matlab
    (buildFHSEnvBubblewrap {
      name = "matlab-fhs";
      chdir = "/home/lfour";
      targetPkgs = pkgs: with pkgs; [
      	alsa-lib
        atk
        cairo
      	cups
      	dbus
      	expat
      	fontconfig
      	freetype
      	gdk-pixbuf
      	glib
      	gtk3
	xorg.libX11
	xorg.libXext
	xorg.libXrender
      	xorg.libXtst
      	xorg.libXi
      	nss
      	pango
      	zlib
	nvidia-vaapi-driver
        libglvnd
      ];
      runScript = "bash";
    })

    # Vivado
    (pkgs.buildFHSEnvBubblewrap {
      name = "vivado-fhs";
      chdir = "/home/lfour/xilinx";
      targetPkgs = pkgs: with pkgs; [
        bash
        coreutils
        util-linux
        zlib
        ncurses5
	libusb1
	openssl
	gawk
	findutils
	diffutils
        libuuid
        xorg.libX11
        xorg.libXext
        xorg.libXrender
        xorg.libXtst
        xorg.libXi
        xorg.libxcb
        xorg.libXau
        xorg.libXdmcp
        xorg.libXcursor
        xorg.libXfixes
        xorg.libXrandr
        xorg.libXinerama
        xorg.libXft
        xorg.libSM
        xorg.libICE
        gtk2
        gtk3
        glib
        libxml2
        libxslt
        tcl
        tk
        nss
        nspr
        expat
        cups
	procps
	libcxxStdenv
	gccStdenv
	glibc
	xdg-utils
        fontconfig
        freetype
        alsa-lib
      ];
      runScript = "bash";
    })
  ###### END ###################
  ];
}
