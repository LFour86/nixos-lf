{ pkgs, ...}:
{
  # Vscode
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      #ms-vscode.makefile-tools
      #ms-vscode.cpptools-extension-pack
      #ms-vscode.cpptools
      #ms-vscode.cmake-tools
      #ms-vscode-remote.vscode-remote-extensionpack
      #ms-vscode-remote.remote-wsl
      #ms-vscode-remote.remote-ssh-edit
      #ms-vscode-remote.remote-ssh
      #ms-vscode-remote.remote-containers
      #github.copilot
      #vadimcn.vscode-lldb
      #twxs.cmake
      #ms-python.python
      #ms-python.debugpy
      #ms-python.pylint
      #ms-python.vscode-pylance
      platformio.platformio-vscode-ide
    ];
  };
}

