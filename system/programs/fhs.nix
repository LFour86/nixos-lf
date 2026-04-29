{ pkgs, ... }:

let
  #tdRoot = "/home/lfour/FHS/TD_4.6.7_Linux";
in
{
  environment.systemPackages = with pkgs; [
    # MATLAB FHS
    (buildFHSEnvBubblewrap {
      name = "matlab-fhs";
      chdir = "/home/lfour/FHS/matlab";
      targetPkgs = pkgs: with pkgs; [
        # Archive & Core Utilities
        procps unzip zlib
        libuuid ncurses glibcLocales

        # Programming & Compilers
        gcc gfortran glibc
        jre python313 

        # System & Hardware
        udev dbus pam
        alsa-lib cups nspr
        nss 

        # Graphics & UI Frameworks
        libGL libgbm libdrm
        mesa cairo pango
        atk gdk-pixbuf fontconfig
        glib gtk2 gtk3
        libxkbcommon libxfixes libxft
      ] ++ (with pkgs.xorg; [
        # X11 Libraries
        libX11 libXext libXi
        libXrender libXt libXtst
        libXrandr libXcursor libXinerama
        libXcomposite libXdamage libXxf86vm
        libICE libSM
      ]);
      extraBwrapArgs = [
        "--bind" "/run/udev" "/run/udev"
        "--bind-try" "/var/run/dbus" "/var/run/dbus"
        "--dev-bind" "/dev" "/dev"
      ];
      runScript = "bash";
      profile = ''
        export FHS=1
        export LANG=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
        export QT_QPA_PLATFORM=xcb           # force X11 over Wayland
        export GDK_BACKEND=x11
        export LIBGL_ALWAYS_INDIRECT=1       # sometimes helps if GL probing fails
      '';
    })

    # Vivado FHS
    (buildFHSEnvBubblewrap {
      name = "vivado-fhs";
      targetPkgs = pkgs: with pkgs; [
        # Basic Tools & Shell
        bash bc coreutils
        file git which
        unzip gnumake nettools

        # Libraries & System
        zlib expat ncurses
        dbus libuuid libusb1
        libxcrypt-legacy

        # Compiler, Build & OpenCL
        gcc stdenv.cc.cc ocl-icd
        opencl-headers tcl graphviz

        # Graphics & UI
        mesa libglvnd glib
        gtk3 fontconfig freetype
      ] ++ (with pkgs.xorg; [
        # X11 Libraries
        libX11 libXext libXtst
        libXrender libXrandr libXi
        libXft libxcb libSM
        libICE libXfixes libXdamage
        libXcomposite libXcursor libxshmfence
      ]);
      extraBwrapArgs = [
        "--bind" "/run/udev" "/run/udev"
        "--bind-try" "/var/run/dbus" "/var/run/dbus"
        "--dev-bind" "/dev" "/dev"
      ];
      runScript = "bash";
      profile = ''
        export FHS=1
        export LANG=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
        export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
      '';
    })

    # TD (Qt5) FHS
    #(buildFHSEnvBubblewrap {
      #name = "td-fhs";
      #chdir = tdRoot;
      #targetPkgs = pkgs: with pkgs; [
        # Basic Utilities
        #bash coreutils file
        #which unzip zlib

        # Build Tools & Compilers
        #gcc cmake gnumake
        #stdenv.cc.cc

        # System & Hardware
        #libusb1 udev dbus
        #libuuid linux-pam icu

        # Graphics & UI (GTK/GL)
        #mesa libGL cairo
        #pango atk gdk-pixbuf
        #glib gtk2 gtk3
        #fontconfig freetype

        # Qt Framework
        #libsForQt5.qt5.qtbase 
        #libsForQt5.qt5.qttools 
        #xkeyboard_config
      #] ++ (with pkgs.xorg; [
        # X11 Libraries
        #libX11 libXext libXi
        #libXrender libXrandr libXcursor
        #libXinerama libXcomposite libXdamage
        #libXfixes libICE libSM
        #libxcb xcbutil
      #]);
      #extraBwrapArgs = [
        #"--bind" "/run/udev" "/run/udev"
        #"--bind-try" "/var/run/dbus" "/var/run/dbus"
        #"--dev-bind" "/dev" "/dev"
      #];
      #runScript = "bash";
      #profile = ''
        #export FHS=1
        #export LANG=en_US.UTF-8
        #export LC_ALL=en_US.UTF-8
        #export QT_QPA_PLATFORM=xcb
        #export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
        #unset XDG_SESSION_TYPE
        #unset XDG_CURRENT_DESKTOP
        #unset GDK_BACKEND
        #unset MOZ_ENABLE_WAYLAND
        #export LD_LIBRARY_PATH=${tdRoot}/lib/Qt/lib:${tdRoot}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH
      #'';
    #})
  ];

  # udev rules (USB)
  services.udev.extraRules = ''
    # FTDI
    ATTRS{idVendor}=="0403", TAG+="uaccess"
    
    # CP210x (Silabs)
    ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", TAG+="uaccess"
    ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea70", TAG+="uaccess"
    
    # CH340/CH341
    ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", TAG+="uaccess"
    ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="5523", TAG+="uaccess"
    
    # Prolific PL2303
    ATTRS{idVendor}=="067b", ATTRS{idProduct}=="2303", TAG+="uaccess"

    # ST-Link/V2, V2-1, V3
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", TAG+="uaccess"
    ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", TAG+="uaccess"
  
    # J-Link
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", TAG+="uaccess"
    ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", TAG+="uaccess"
    
    # Altera USB Blaster
    ATTRS{idVendor}=="09fb", ATTRS{idProduct}=="6001", TAG+="uaccess"
  '';
}

