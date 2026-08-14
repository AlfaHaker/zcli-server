# zcli-server Documentation & Cheatsheets

Welcome to the official documentation and cheatsheet hub for **`zcli-server`** — the lightweight, modular, headless-first NixOS server distribution.

---

## 📚 Cheatsheets Index

| Cheatsheet | Description |
| :--- | :--- |
| **[zcli-server Guide](./zcli-server.md)** | CLI management tool (`zcli-server rebuild`), host variables, and module switches. |
| **[Caddy Proxy Guide](./caddy-proxy.md)** | Reverse proxy routing (`app.hostname`, `hostname/app`), Docker/Incus proxying, `basic_auth`, and LAN firewall rules. |
| **[Dual NVMe Storage Guide](./storage-dual-nvme.md)** | Multi-drive NVMe storage architecture, Docker `data-root`, Ollama `modelsDir`, and Incus mounts. |
| **[Containers & Virtualization](./containers-virtualization.md)** | Managing Docker containers, Incus instances, LXC, and Virt-Manager (VMM). |
| **[Zellij & TTY Experience](./zellij-tty.md)** | Zellij terminal multiplexer shortcuts, pitch-black TTY styling, and on-demand Hyprland GUI (`start-gui`). |
| **[Yazi File Manager](./yazi-file-manager.md)** | Fast Rust TTY file manager shortcuts, navigation, file ops, and zoxide jumping. |
| **[NixOS Beginner Guide](./nix-beginner.md)** | Essential Nix Flakes commands, configuration editing, and system rollback. |

---

## ⚡ Quick Start Commands

```bash
# Rebuild and switch NixOS configuration
zcli-server rebuild

# Rebuild for next boot
zcli-server rebuild-boot

# Update flake locks & rebuild
zcli-server update

# Clean old system generations
zcli-server cleanup

# Launch Zellij Terminal Multiplexer
z

# Launch Hyprland GUI on demand from TTY
start-gui
```
