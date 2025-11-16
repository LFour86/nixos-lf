{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ###### FHS Environment ################
    # Matlab
    (buildFHSEnvBubblewrap {
      name = "matlab-fhs";
      chdir = "/home/lfour/FHS/matlab";
      targetPkgs = pkgs: with pkgs; [
        cacert
        alsa-lib # libasound2
        atk
        glib
        glibc
        cairo
        cups
        dbus
        fontconfig
        gdk-pixbuf
        gst_all_1.gst-plugins-base
        gst_all_1.gstreamer
        gtk3
        nspr
        nss
        pam
        pango
        python3
        libselinux
        libsndfile
        glibcLocales
        procps
        unzip
        zlib
        linux-pam
        gtk2
        at-spi2-atk
        at-spi2-core
        libdrm
        # Required by Simulink
        mesa
        gcc
        gfortran
        # NixOS specific
        udev
        jre
        ncurses # Needed for CLI
        # Keyboard input may not work in simulink otherwise
        libxkbcommon
        xkeyboard_config
        libglvnd
        libuuid
        libxcrypt
        libxcrypt-legacy
        libgbm
        ] ++ (with pkgs.xorg; [
          libSM
          libX11
          libxcb
          libXcomposite
          libXcursor
          libXdamage
          libXext
          libXfixes
          libXft
          libXi
          libXinerama
          libXrandr
          libXrender
          libXt
          libXtst
          libXxf86vm
          libICE
        ]);
      runScript = "bash";
    })

    # Vivado
    (pkgs.buildFHSEnvBubblewrap {
      name = "vivado-fhs";
      chdir = "/home/lfour/FHS/xilinx";
      targetPkgs = pkgs: with pkgs; [
        bash
        coreutils
	curl
	doxygen
        util-linux
	udev
        zlib
        ncurses5
        libusb1
        openssl
	ocl-icd
        gawk
        findutils
        diffutils
        libuuid
	libdrm
	valgrind
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

