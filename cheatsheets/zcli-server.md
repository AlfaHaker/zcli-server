# zcli-server Management Guide

The `zcli-server` utility is the primary CLI management interface for building, updating, and maintaining your NixOS server system.

---

## ⚡ Initial First Build vs Rebuilds

* **Initial First Build** (before `zcli-server` CLI is installed on `$PATH`):
  ```bash
  NIX_CONFIG="experimental-features = nix-command flakes"
  sudo nixos-rebuild switch --flake .#amd
  ```
* **Subsequent Rebuilds** (once `zcli-server` is installed):
  ```bash
  zcli-server rebuild
  ```

---

## 🚀 CLI Commands

| Command | Action |
| :--- | :--- |
| `zcli-server rebuild` | Rebuilds and immediately activates the NixOS configuration (`nh os switch`). |
| `zcli-server rebuild-boot` | Rebuilds the system and sets it as the default for the next reboot (`nh os boot`). |
| `zcli-server update` | Updates flake inputs (`flake.lock`) and rebuilds the system (`nh os switch --update`). |
| `zcli-server cleanup` | Cleans old NixOS system generations to free up disk space (`nh clean`). |
| `zcli-server diag` | Generates a system diagnostic hardware report at `~/zcli-server-diag.txt`. |
| `zcli-server help` | Displays available CLI commands and help information. |

---

## ⚙️ Modular Service Toggles (`hosts/$host/variables.nix`)

Every service in `zcli-server` is isolated into its own `.nix` module in `modules/core/` and can be enabled or disabled per host in `hosts/<hostname>/variables.nix`:

```nix
  # Service Enablement Switches
  sshEnable = true;          # OpenSSH Server (Port 22)
  dockerEnable = true;       # Docker Engine
  ollamaEnable = true;       # Ollama Local AI Runner
  zellijEnable = true;       # Zellij Terminal Multiplexer
  keepassEnable = true;      # KeePassXC & kpcli TTY password tools
  hyprlandEnable = true;     # Minimal Hyprland compositor (on-demand via start-gui)
  zenBrowserEnable = true;   # Zen Browser
  incusEnable = false;       # Incus Linux Containers daemon
  lxcEnable = false;         # LXC tools
  vmmEnable = true;          # Virt-Manager / Libvirt / QEMU-KVM
  proxyEnable = true;        # Caddy Reverse Proxy
```
