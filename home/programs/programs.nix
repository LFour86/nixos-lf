{ pkgs, ...}:
{
  # Vscode
  programs.vscode = {
    enable = true;
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

  # Enable fish
  programs.fish = {
    enable = true;
    shellAliases = {
      li = "lsd --human-readable --all";
      tt = "tree";
      update = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#lfour";
      garbage = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
      flake = "cd /etc/nixos && sudo nix flake update";
    };
  };
}

