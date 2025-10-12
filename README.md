# NixOS‑LF — My NixOS Configuration

This repository contains my personal NixOS configuration files, modules, and customizations designed to deliver a reproducible, performant, and modular NixOS setup.  

---

## 📁 Repository Layout

```
nixos-lf/
├── flake.nix
├── system/
│   ├── config/
│   ├── hardware/
│   └── programs/
├── home/
│   ├── config/
│   └── programs/
├── overlays/
└── README.md
```

- **flake.nix** — the root Nix flake entry point  
- **system/** — NixOS system configurations
- **home/** — home-manager configurations  
- **overlays/** — custom package overlays / overrides  
- **README.md** — this file  

---

## ✨ Key Features & Philosophy

- **Modularity & Reuse**  
  Clean separation of concerns. You can easily import or reuse parts of this configuration in other NixOS systems.

- **Declarative & Idempotent**  
  All configuration is described declaratively. Re-building applies consistent and repeatable states.

- **Hardware-aware Configuration**  
  Auto-detects and handles graphics, input devices, kernel modules, etc.

- **Desktop & Wayland Focused**  
  Preconfigured for modern desktop environments (Wayland, Hyprland, etc.).

- **Custom Overlays & Packages**  
  You can extend or override packages via `overlays/`.

- **Security & Performance**  
  Integrated optimizations, service hardening, and careful default settings.

---

## 🛠 Usage Guide

Here’s how to adopt or replicate this configuration on a new NixOS machine:

1. **Clone the repository**  
   ```bash
   git clone https://github.com/LFour86/nixos-lf.git
   cd nixos-lf
   ```

2. **Install or switch to this flake**  
   For example:
   ```bash
   sudo nixos-rebuild switch --flake .#laptop
   ```

   Adjust the host name (e.g. `#laptop`, `#home-server`) to match files under `system/config/user.nix` and `home/default.nix`.

3. **Customize your host config**  
   Edit `system/config/user.nix` and `home/default.nix` to override or enable services specific to your machine.

4. **Add or override modules**  
   Use `system/` and `overlays/` to customize behavior globally or per host.

5. **Test and iterate**  
   Use `nixos-rebuild` frequently to test changes. The flake structure gives safety via atomic rollbacks.

---

## 🔄 Advanced Topics & Tips

- **Overlays**  
  Use `overlays/my-overlays.nix` to override or extend Nix packages globally.

- **Device Modules**  
  Place hardware-specific modules under `system/hardware/`, e.g. GPU, input devices, firmware.

- **Service Modules**  
  Place service configurations (e.g. `ssh`, `firewall`, `network`) in `system/programs/` and `system/config/`.

- **Desktops / UI**  
  Desktop environments, window managers, status bars, Wayland setups go under `system/coonfig/desktop.nix`.

- **Rollbacks & Safe Changes**  
  NixOS ensures you can roll back any change with:
  ```bash
  sudo nixos-rebuild switch --rollback
  ```

---

## 🚀 Roadmap & Future Ideas

- [ ] Add automated host detection (e.g. laptop vs server)  
- [ ] Extend support for multiple desktops (GNOME, KDE, Sway)  
- [ ] Integrate more custom overlays (games, dev tools)  
- [ ] Add automated hardware testing module  
- [ ] Enhance documentation with module dependency graph  

---

## 📜 License

This project is licensed under the MIT License. You are free to use, modify, and share it.

---

## 📬 Contact & Feedback

If you run into issues or have suggestions, feel free to open an issue or pull request.

Enjoy NixOS!  
— LFour86  
