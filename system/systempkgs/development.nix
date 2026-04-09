{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Build tools
    bear
    cmake
    coreutils-full
    direnv
    devenv
    gnumake
    meson
    ninja

    # Mixed
    gcc_multi
    gdb
    
    # C / C++
    llvmPackages_latest.clang
    llvmPackages_latest.clang-tools
    llvmPackages_latest.lldb
    llvmPackages_latest.libcxx
    llvmPackages_latest.libllvm

    # Electron
    electron

    # Java
    jdk

    # .NET
    dotnet-sdk
    dotnet-runtime

    # Python
    python314

    # Node.js
    nodejs_24

    # Rust
    cargo
    rustc
    rustfmt

    # Go
    go
  ];
}

