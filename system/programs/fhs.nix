{ config, libs, pkgs, ... }:

let
  #tdRoot = "/home/lfour/FHS/TD_4.6.7_Linux";
  XilinxRoot = "/home/lfour/FHS/Xilinx";
in
{
  environment.systemPackages = with pkgs; [
    # MATLAB FHS
    (buildFHSEnvBubblewrap {
      name = "matlab-fhs";
      chdir = "/home/lfour/FHS/matlab";
      targetPkgs = pkgs: with pkgs; [
        # Archive & Core Utilities
        glibcLocales libuuid ncurses
        procps unzip zlib

        # Programming & Compilers
        gcc gfortran glibc
        jre python313

        # System & Hardware
        alsa-lib cups dbus
        nspr nss pam
        udev

        # Graphics & UI Frameworks
        atk cairo fontconfig
        gdk-pixbuf glib gtk2
        gtk3 libdrm libgbm
        libGL libxfixes libxft
        libxkbcommon mesa pango
      ] ++ (with pkgs.xorg; [
        # X11 Libraries
        libICE libSM libX11
        libXcomposite libXcursor libXdamage
        libXext libXi libXinerama
        libXrandr libXrender libXt
        libXtst libXxf86vm
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

    # Xilinx FHS
    (buildFHSEnvBubblewrap {
      name = "vivado-fhs";
      targetPkgs = pkgs: with pkgs; [
        # Basic Tools & Shell
        bash bc coreutils
        file git gnumake
        nettools unzip which

        # Libraries & System
        dbus expat libpng
        libusb1 libuuid libxcrypt-legacy
        ncurses5 pixman zlib

        # Compiler, Build & OpenCL
        gcc graphviz ocl-icd
        opencl-headers stdenv.cc.cc tcl

        # Graphics & UI
        fontconfig freetype glib
        gtk3 libglvnd mesa
      ] ++ (with pkgs.xorg; [
        # X11 Libraries
        libICE libSM libX11
        libxcb libXcomposite libXcursor
        libXdamage libXext libXfixes
        libXft libXi libXrandr
        libXrender libxshmfence libXtst
      ]);
      extraBwrapArgs = [
        "--bind" "/run/udev" "/run/udev"
        "--bind-try" "/var/run/dbus" "/var/run/dbus"
        "--dev-bind" "/dev" "/dev"
        "--bind" "/sys" "/sys"
        "--bind" "/proc" "/proc"
      ];
      runScript = "bash";
      profile = ''
        export FHS=1
        export LANG=en_US.UTF-8
        export LC_ALL=en_US.UTF-8
        export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"

        XILINX_LIBS=(
          "${XilinxRoot}/2025.2/Vitis/lib/lnx64.o/Ubuntu/24"
          "${XilinxRoot}/2025.2/PDM/lib/lnx64.o/Ubuntu/24"
          "${XilinxRoot}/2025.2/Vivado/lib/lnx64.o/Ubuntu/24"
          "${XilinxRoot}/2025.2/Model_Composer/lib/lnx64.o/Ubuntu/24"
          "${XilinxRoot}/xic/lib/lnx64.o/Ubuntu/24"
        )
        NEW_PATHS=$(IFS=:; echo "''${XILINX_LIBS[*]}")
        NEW_PATHS="$NEW_PATHS:/run/opengl-driver/lib:${pkgs.lib.makeLibraryPath (with pkgs; [
          pixman 
          ncurses5
        ])}"
        export LD_LIBRARY_PATH="$NEW_PATHS:$LD_LIBRARY_PATH"
      '';
    })

    # TD (Qt5) FHS
    #(buildFHSEnvBubblewrap {
      #name = "td-fhs";
      #chdir = tdRoot;
      #targetPkgs = pkgs: with pkgs; [
        # Basic Utilities
        #bash coreutils file
        #unzip which zlib

        # Build Tools & Compilers
        #cmake gcc gnumake
        #stdenv.cc.cc

        # System & Hardware
        #dbus icu libusb1
        #libuuid linux-pam udev

        # Graphics & UI (GTK/GL)
        #atk cairo fontconfig
        #freetype gdk-pixbuf glib
        #gtk2 gtk3 libGL
        #mesa pango

        # Qt Framework
        #libsForQt5.qt5.qtbase 
        #libsForQt5.qt5.qttools 
        #xkeyboard_config
      #] ++ (with pkgs.xorg; [
        # X11 Libraries
        #libICE libSM libX11
        #libxcb libXcomposite libXcursor
        #libXdamage libXext libXfixes
        #libXi libXinerama libXrandr
        #libXrender xcbutil
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
}

