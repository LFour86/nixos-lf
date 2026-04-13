{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Base cli
    bat
    fd
    file
    lsd
    lshw
    lsof
    pciutils
    psutils
    ripgrep-all
    tree
    usbutils

    # Archives
    p7zip
    peazip
    unrar
    unzip
    zip

    # Download
    aria2
    wget

    # Network
    dhcpcd

    # Monitoring
    btop
    fastfetch
    lm_sensors

    # Editors
    neovim
    vim

    # Media
    ffmpeg-full
    
    # Misc
    cmus
    sl
  ];
}

