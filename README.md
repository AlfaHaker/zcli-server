<div align="center">

# 🚀 `zcli-server`
### Modular, Headless-First NixOS Distribution for Terminal Productivity & Server Operations

[![NixOS](https://img.shields.io/badge/NixOS-Unstable-blue.svg?logo=nixos&logoColor=white)](https://nixos.org)
[![Zellij](https://img.shields.io/badge/Multiplexer-Zellij-red.svg?logo=rust&logoColor=white)](https://zellij.dev)
[![Caddy](https://img.shields.io/badge/Proxy-Caddy-green.svg?logo=caddy&logoColor=white)](https://caddyserver.com)
[![Status](https://img.shields.io/badge/Status-Active%20%26%20Verified-brightgreen.svg)]()

</div>

---

## 🌟 Key Features

* 🖥️ **Headless & Pure TTY Minimalist Boot**: Boots strictly into text console mode (`displayManager = "tui"`) with zero background desktop overhead, crisp high-DPI Terminus console font (`ter-v32n`), and pitch-black (`#000000`) OLED color palette.
* ⚡ **Zellij Terminal Multiplexer**: Integrated state-of-the-art Rust terminal multiplexer (`tmux` alternative) featuring modal control, tabs, mouse support, floating panes, and custom pitch-black layout (`z` or `zellij`).
* 🛠️ **`zcli-server` System Rebuild CLI**: Custom management tool providing `zcli-server rebuild`, `rebuild-boot`, `update`, `cleanup`, and `diag`.
* 🌐 **Caddy Reverse Proxy**: Integrated Caddy proxy in `hosts/$host/proxy.nix` supporting subdomains (`app.hostname`), subpaths (`hostname/app` via `handle_path`), password protection (`basic_auth`), and automatic HTTPS.
* 🐳 **Containerization & Virtualization**: Modular host-switch control for **Docker** (custom `data-root`), **Incus** (Linux Containers & VMs), **LXC**, and **Virt-Manager** (KVM/Libvirt).
* 🤖 **Local AI (Ollama)**: Pre-configured Ollama AI service with dedicated storage directory (`modelsDir`).
* 💾 **Dual NVMe Multi-Drive Architecture**: Dedicated storage redirection (`/mnt/nvme-storage`) offloading container layers, volumes, and AI models to secondary high-speed NVMe drives.
* 🔑 **KeePass Security Tools**: Interactive `kpcli` TTY password manager shell and `keepassxc-cli`.
* 🖥️ **On-Demand Minimal GUI**: Run `start-gui` from TTY anytime to launch Hyprland desktop, Zen Browser, and KeePassXC.

---

## ⚙️ Modular Host Controls (`hosts/$host/variables.nix`)

Every service is isolated in `modules/core/` and controlled by host boolean switches in `hosts/<hostname>/variables.nix`:

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

  # Host-Specific Storage Paths
  dockerDataRoot = "/mnt/nvme-storage/docker";
  ollamaModelsDir = "/mnt/nvme-storage/ollama";
```

---

## 🖥️ Installation & Host Setup Guide

### Why Create a Host Configuration?
Different physical machines (servers, workstations, VMs) have distinct hardware components (GPUs, storage UUIDs, network interfaces, static IPs) and operational roles. Creating a dedicated host configuration isolates machine-specific settings (`hardware.nix`, `network.nix`, `proxy.nix`, `variables.nix`) while sharing clean core system modules across all your machines.

### Step 1: Clone the Repository
```bash
git clone https://github.com/AlfaHaker/zcli-server.git ~/zcli-server
cd ~/zcli-server
```

### Step 2: Copy Default Host Template to Machine Hostname
Always start by copying the `default` host template to your target hostname:
```bash
cp -r hosts/default hosts/$(hostname)
git add .
```

### Step 3: Set Your Hostname & Username in `flake.nix`
Edit `flake.nix` (lines 54 & 56):
```nix
    host = "$(hostname)";      # Replace with your machine hostname (or "default")
    username = "yourusername"; # Replace with your Linux username
```

### Step 4: Configure Host Variables (`hosts/<your-hostname>/variables.nix`)
Edit `hosts/<your-hostname>/variables.nix` to customize:
* `gitUsername` & `gitEmail`
* Service enablement switches (`dockerEnable`, `sshEnable`, `ollamaEnable`, `proxyEnable`, `vmmEnable`)
* Host-specific storage paths (`dockerDataRoot`, `ollamaModelsDir`)

### Step 5: Generate Hardware Configuration
```bash
nixos-generate-config --show-hardware-config > hosts/$(hostname)/hardware.nix
git add .
```

### Step 6: Initial System Build
*(Note: On initial installation, run standard `nixos-rebuild` to install `zcli-server`)*:
```bash
# Initial First Build (replace 'amd' with your GPU profile: amd, nvidia, intel, vm):
NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake .#amd

# All Future Rebuilds (once zcli-server is installed):
zcli-server rebuild
```

---

## ⚡ Quick Start Commands

```bash
# Rebuild and switch NixOS configuration
zcli-server rebuild

# Rebuild for next boot
zcli-server rebuild-boot

# Update flake locks & rebuild system
zcli-server update

# Clean old NixOS system generations
zcli-server cleanup

# Launch Zellij Terminal Multiplexer
z

# Launch Hyprland GUI on demand from TTY
start-gui
```

---

## 📚 Cheatsheets & Documentation

All guides are organized inside the **[cheatsheets/](./cheatsheets/README.md)** directory:

* **[zcli-server CLI Guide](./cheatsheets/zcli-server.md)** — Management CLI reference and options.
* **[Caddy Proxy Guide](./cheatsheets/caddy-proxy.md)** — Subdomain, subpath, basic_auth, and firewall proxy rules.
* **[Dual NVMe Storage Guide](./cheatsheets/storage-dual-nvme.md)** — Multi-drive storage architecture and redirection.
* **[Containers & Virtualization](./cheatsheets/containers-virtualization.md)** — Docker, Incus, LXC, and VMM command reference.
* **[Zellij & TTY Guide](./cheatsheets/zellij-tty.md)** — Terminal multiplexer shortcuts, TTY polish, and on-demand GUI.
* **[NixOS Beginner Guide](./cheatsheets/nix-beginner.md)** — Flake maintenance, configuration editing, and rollback.

---

## 📂 Repository Structure

```
/home/alfa/zcli-server/
├── flake.nix                  # Flake entrypoint (AMD/Intel/Nvidia/VM profiles)
├── README.md                  # Project Overview
├── cheatsheets/               # Cheatsheets & Guides directory
├── hosts/
│   └── default/
│       ├── default.nix
│       ├── hardware.nix
│       ├── network.nix       # Network & Firewall rules
│       ├── proxy.nix         # Caddy Reverse Proxy virtual hosts
│       └── variables.nix     # Host service toggles & paths
└── modules/
    ├── core/                  # Modular single-service system modules
    │   ├── virtualisation.nix # Docker, Incus, LXC, VMM, Podman, VBox
    │   ├── ssh.nix            # OpenSSH daemon
    │   ├── ollama.nix         # Ollama AI service
    │   ├── hyprland.nix       # Hyprland setup
    │   ├── zellij.nix         # Zellij package module
    │   └── keepass.nix        # KeePassXC & kpcli tools
    └── home/                  # Home-manager user environment & scripts
        ├── zellij/            # Zellij config & layouts
        └── scripts/
            ├── zcli-server.nix# Custom CLI rebuild script
            └── start-gui.nix  # On-demand GUI launcher
```

---

##  Credits & Attribution
This project is based on and derived from **[ZaneyOS](https://gitlab.com/Zaney/zaneyos/)** created by Tyler Kelley (Zaney).

---

## 📜 License
This project is licensed under the **MIT License** — see the [LICENSE.md](./LICENSE.md) file for full details.
