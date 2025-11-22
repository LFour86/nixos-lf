{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.override {
      commandLineArgs = [ "--wayland-text-input-version=3" ];
    };
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-vscode.makefile-tools
      ms-vscode.cpptools-extension-pack
      ms-vscode.cpptools
      ms-vscode.cmake-tools
      ms-vscode-remote.vscode-remote-extensionpack
      ms-vscode-remote.remote-wsl
      ms-vscode-remote.remote-ssh-edit
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-containers
      github.copilot
      vadimcn.vscode-lldb
      twxs.cmake
      ms-python.python
      ms-python.debugpy
      ms-python.pylint
      ms-python.vscode-pylance
      platformio.platformio-vscode-ide
    ];
  };

  # Notice
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      width =350;
      default-timeout = 5000; # ms
      background-color="#1e1e2e";
      text-color="#cdd6f4";
      border-color="#cba6f7";
      progress-color="over #313244";
      border-size = 2;
      border-radius = 8;
      padding = 12;
      font = "Maple Mono NF 10";
    };
  };
}

