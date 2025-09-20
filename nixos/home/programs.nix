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

  # Enable zsh
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    shellAliases = {
      li = "lsd --human-readable --all";
      tt = "tree";
      update = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#lfour";
      garbage = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
      flake = "cd /etc/nixos && sudo nix flake update";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
	{ name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
    initContent = ''
      # Source Powerlevel10k config
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
  };
  home.file.".p10k.zsh".source = ./p10k.zsh;
}

