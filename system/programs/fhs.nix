{ pkgs, ... }:

let
  tdRoot = "/home/lfour/FHS/TD_4.6.7_Linux";
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
        alsa-lib atk cairo cups dbus fontconfig
        gdk-pixbuf glib gtk2 gtk3
        libdrm libuuid libxkbcommon
        mesa ncurses nspr nss pam pango
        procps python3 zlib unzip
        udev jre glibc glibcLocales
        gcc gfortran
      ] ++ (with pkgs.xorg; [
        libX11 libXext libXi libXrender
        libXt libXtst libXrandr libXcursor
        libXinerama libXcomposite libXdamage
        libXxf86vm libICE libSM
      ]);
      runScript = "bash";
    })

    ############################################
    ## Vivado FHS
    ############################################
    (buildFHSEnvBubblewrap {
      name = "vivado-fhs";
      targetPkgs = pkgs: with pkgs; [
        bash bc coreutils file git gnumake
        graphviz which unzip
        expat dbus zlib tcl ncurses nettools
        libuuid libusb1
        gcc stdenv.cc.cc
        mesa libglvnd
        ocl-icd opencl-headers
        glib gtk3 fontconfig freetype
        libxcrypt-legacy
      ] ++ (with pkgs.xorg; [
        libX11 libXext libXtst libXrender
        libXrandr libXi libXft libxcb
        libSM libICE libXfixes libXdamage
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
        bash coreutils file which unzip
        zlib libusb1 udev dbus libuuid
        icu mesa libGL
        gtk2 gtk3 atk cairo pango
        gdk-pixbuf glib fontconfig freetype
        gcc cmake gnumake
        stdenv.cc.cc
        linux-pam
        libsForQt5.qt5.qtbase
        libsForQt5.qt5.qttools
        xkeyboard_config
      ] ++ (with pkgs.xorg; [
        libX11 libXext libXi libXrender
        libXrandr libXcursor libXinerama
        libXcomposite libXdamage libXfixes
        libICE libSM libxcb xcbutil
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
  ];

  ############################################
  ## udev rules (Vivado / FPGA / USB)
  ############################################
  services.udev.extraRules = ''
    ATTRS{idVendor}=="03fd", TAG+="uaccess"
    ATTRS{idVendor}=="1443", TAG+="uaccess"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", TAG+="uaccess"
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", TAG+="uaccess"
  '';
}

