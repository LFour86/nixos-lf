{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ###### FHS Environment ################
    # Matlab
    (buildFHSEnvBubblewrap {
      name = "matlab-fhs";
      chdir = "/home/lfour/FHS/matlab";
      targetPkgs = pkgs: with pkgs; [
        alsa-lib atk glib
        glibc cacert cairo
        cups dbus fontconfig
        gdk-pixbuf gst_all_1.gst-plugins-base gst_all_1.gstreamer
        gtk3 nspr nss
        pam pango python3
        procps libselinux libsndfile
        glibcLocales unzip zlib
        linux-pam gtk2 at-spi2-atk
        at-spi2-core libdrm

        # Required by Simulink
        mesa gcc gfortran

        # NixOS specific
        udev jre ncurses # Needed for CLI
        # Keyboard input may not work in simulink otherwise
        libxkbcommon xkeyboard_config libglvnd
        libuuid libxcrypt libxcrypt-legacy
        libgbm
        ] ++ (with pkgs.xorg; [
          libSM libX11 libxcb
          libXcomposite libXcursor libXdamage
          libXext libXfixes libXft
          libXi libXinerama libXrandr
          libXrender libXt libXtst
          libXxf86vm libICE
        ]);
      runScript = "bash";
    })

    (buildFHSEnvBubblewrap {
    #Note: The latest 2025.1 version has been tested and is confirmed to work.
    #After installation is complete, 
    #you must copy a copy of libtinfo.so.5 into ./Xilinx/2025.1/Vivado/lib/lnx64.o.
    #The file libtinfo.so.5 can be found in the Vivado installation directory, 
    #for example under ./Xilinx/2025.1/Vivado/lib/lnx64.o/Ubuntu/24.
      name = "vivado-fhs"; 
      targetPkgs = pkgs: with pkgs; [
        bash bc coreutils
        expat dbus file
	unzip which git
	gnumake graphviz zlib
	tcl ncurses nettools
	libuuid libusb1

        # Toolchain
        gcc libcxxStdenv stdenv.cc.cc

        # OpenGL + X11
        mesa libglvnd libxcrypt-legacy
        ocl-icd opencl-headers

        # glib / gtk
        glib gtk3 fontconfig
        freetype

        # Xorg libs
        xorg.libX11 xorg.libXext xorg.libXtst
        xorg.libXrender xorg.libXrandr xorg.libXi
        xorg.libXft xorg.libxcb xorg.libSM
        xorg.libICE xorg.libXfixes xorg.libXdamage
        xorg.libXcomposite xorg.libXcursor xorg.libxshmfence
      ];

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
	export LD_LIBRARY_PATH=/lib:/usr/lib64:/run/opengl-driver/lib:${pkgs.lib.makeLibraryPath (with pkgs; [
	  coreutils
          libusb1
          ncurses
          libxcrypt-legacy
          glib
          gtk3
	  graphviz
          fontconfig
          freetype
	  nettools
	  stdenv.cc.cc
          xorg.libX11
          xorg.libXext
          xorg.libXtst
          xorg.libXrender
          xorg.libXrandr
          xorg.libXi
          xorg.libXft
          xorg.libxcb
        ])}:$LD_LIBRARY_PATH
      '';
    })
  ];

  services.udev.extraRules = ''
    # Xilinx Platform Cable
    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", TAG+="uaccess"
    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0007", TAG+="uaccess"
    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0009", TAG+="uaccess"
    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="000d", TAG+="uaccess"
    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="000f", TAG+="uaccess"
    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0013", TAG+="uaccess"
    ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0015", TAG+="uaccess"

    # Digilent / FTDI
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1443", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6014", TAG+="uaccess"
  '';
}
