# NixOS Configuration

A declarative NixOS system configuration using Nix flakes, featuring a customized desktop environment and various productivity tools.

---
## ⚠️ NOTICE / WARNING ⚠️

> **Do NOT blindly apply this configuration!**

- **Change the username**: Make sure to update all references to my username (`lfour`) to your own throughout the configs.
- **Hardware Partitioning**: This config uses `disko`, so you'll need to edit `system/hardware/disko.nix` to match your disk layout. (See [this clean install example](https://github.com/LFour86/nixos-disko-lf).)
- **Adapt to Your Needs**: This config is tailored for my hardware and preferences. Review and adjust all settings before use!

---

## Features

- **Desktop Environment**: Niri Wayland compositor with Noctalia shell and GNOME
- **File System**: BTRFS with LUKS2
- **Shell**: Nushell with custom config
- **Browser**: Firefox Browser and Google Chrome
- **System Management**: Home Manager for user configuration
- **Hardware Support**: NVIDIA, AMDGPU, Bluetooth, audio, and other hardware configurations
- **Security**: SSH, firewall, and security hardening
- **Virtualization**: Docker and other virtualization tools

## Usage

1.  Clone this repository:
    ```bash
    git clone https://github.com/yourusername/nixos-lf.git
    sudo cp -r nixos-lf/ /etc/nixos
    ```

2.  Update the config files as needed, for example:
    - In `system/config/user.nix`, change `"lfour"` to your username.

3.  Build and switch to the new configuration:
    ```bash
    sudo nixos-rebuild switch --flake .#yourname
    ```
    *(Replace `yourname` with your actual hostname or the flake output you wish to deploy.)*

## Directory Structure

```
.
├── flake.nix              # Main flake configuration
├── flake.lock             # Flake lock file
├── home/                  # User configuration
│   ├── config/            # User-specific configs
│   ├── programs/          # User programs
│   ├── wallpapers/        # Wallpaper files
│   └── userpkgs/          # User packages
├── overlays/              # Nixpkgs overlays
│   └── local_apps/        # Custom local applications
└── system/                # System-wide configuration
    ├── config/            # System configs
    ├── hardware/          # Hardware-specific configurations
    ├── programs/          # System programs and services
    └── systempkgs/        # System packages
```

## Customization

- **System Config**: Edit files in `system/config/`
- **User Config**: Edit files in `home/config/`
- **Programs**: Modify `system/programs/` and `home/programs/`
- **Hardware**: Adjust settings in `system/hardware/`
- **Applications**: See `home/userpkgs/`, `overlays/` and `system/systempkgs/`

## Dependencies

- NixOS 25.11 and unstable
- Home Manager
- Noctalia shell
- Disko
- Impermanence

## License

This project is licensed under the MIT License - see the LICENSE file for details.