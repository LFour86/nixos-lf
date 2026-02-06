{ pkgs, ... }:

let
  tdRoot = "/home/lfour/FHS/TD_4.6.7_Linux";
  lcedaRoot = "/home/lfour/FHS/lceda-pro";
in
{
  environment.systemPackages = with pkgs; [
    ############################################
    ## Matlab FHS
    ############################################
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

    ############################################
    ## Vivado FHS
    ############################################
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

    ############################################
    ## TD (Qt5) FHS
    ############################################
    (buildFHSEnvBubblewrap {
      name = "td-fhs";
      chdir = tdRoot;
      targetPkgs = pkgs: with pkgs; [
        # Basic Utilities
        bash coreutils file
        which unzip zlib

        # Build Tools & Compilers
        gcc cmake gnumake
        stdenv.cc.cc

        # System & Hardware
        libusb1 udev dbus
        libuuid linux-pam icu

        # Graphics & UI (GTK/GL)
        mesa libGL cairo
        pango atk gdk-pixbuf
        glib gtk2 gtk3
        fontconfig freetype

        # Qt Framework
        libsForQt5.qt5.qtbase 
        libsForQt5.qt5.qttools 
        xkeyboard_config
      ] ++ (with pkgs.xorg; [
        # X11 Libraries
        libX11 libXext libXi
        libXrender libXrandr libXcursor
        libXinerama libXcomposite libXdamage
        libXfixes libICE libSM
        libxcb xcbutil
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
        export QT_QPA_PLATFORM=xcb
        export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
        unset XDG_SESSION_TYPE
        unset XDG_CURRENT_DESKTOP
        unset GDK_BACKEND
        unset MOZ_ENABLE_WAYLAND
        export LD_LIBRARY_PATH=${tdRoot}/lib/Qt/lib:${tdRoot}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH
      '';
    })

    ############################################
    ## LCEDA Pro FHS
    ############################################
    (buildFHSEnvBubblewrap {
      name = "lceda-fhs";
      chdir = "/home/lfour/FHS/lceda-pro";
      targetPkgs = pkgs: with pkgs; [
        # Basic command line tools
        bash coreutils file 
        which unzip zlib

        # Graphics & Hardware Acceleration
        mesa libglvnd libdrm
        libgbm

        # Electron / Chromium Dependencies
        alsa-lib cups dbus
        expat nspr nss
        systemd udev

        # UI Framework (GTK3)
        cairo pango gtk3
        glib gdk-pixbuf at-spi2-atk
        at-spi2-core libxkbcommon

        # Fonts & Compiler libs
        fontconfig freetype gcc.cc.lib
      ] ++ (with pkgs.xorg; [
        # X11 Libraries
        libX11 libXcomposite libXdamage
        libXext libXfixes libXrandr
        libxcb libXcursor libXi
        libXrender libXtst libXScrnSaver
        libxshmfence
      ]);
      
      extraBwrapArgs = [
        "--bind" "/run/udev" "/run/udev"
        "--bind-try" "/var/run/dbus" "/var/run/dbus"
        "--dev-bind" "/dev" "/dev"
      ];
      runScript = "bash";
      
      profile = ''
        export FHS=1
        # Try to force software rendering if hardware acceleration fails
        # export LIBGL_ALWAYS_SOFTWARE=1 
        export LD_LIBRARY_PATH=${lcedaRoot}:/run/opengl-driver/lib:$LD_LIBRARY_PATH
      '';
    })
  ];

  ############################################
  ## udev rules (USB)
  ############################################
  services.udev.extraRules = ''
    ATTRS{idVendor}=="03fd", TAG+="uaccess"
    ATTRS{idVendor}=="1443", TAG+="uaccess"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", TAG+="uaccess"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", TAG+="uaccess"
  '';
}

