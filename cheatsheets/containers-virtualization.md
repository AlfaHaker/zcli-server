# Containers & Virtualization Cheatsheet

Reference guide for managing Docker containers, Incus instances, LXC, and Virt-Manager (VMM) in `zcli-server`.

---

## 🐳 1. Docker Engine

* **Status**: Enabled via `dockerEnable = true;` in `variables.nix`.
* **User Permission**: User `alfa` is automatically added to `docker` group (no `sudo` required).
* **Storage Location**: Store containers on `/mnt/nvme-storage/docker`.

### Common Docker Commands
```bash
# List running containers
docker ps

# Start container bound to localhost port 8080
docker run -d --name webapp -p 127.0.0.1:8080:80 nginx:alpine

# Docker Compose management
docker compose up -d
docker compose down

# TTY Terminal Docker UI
lazydocker
```

---

## 📦 2. Incus (Linux Containers & VMs)

* **Status**: Controlled via `incusEnable` in `variables.nix`.
* **User Permission**: User `alfa` added to `incus-admin` group.

### Common Incus Commands
```bash
# Initialize Incus storage and networking
incus admin init

# Launch Ubuntu container
incus launch images:ubuntu/24.04 web1

# List running instances & IP addresses
incus list

# Execute interactive shell inside instance
incus exec web1 -- bash

# Stop and delete instance
incus stop web1
incus delete web1
```

---

## 🖥️ 3. Virt-Manager / Libvirt (KVM Virtual Machines)

* **Status**: Controlled via `vmmEnable` in `variables.nix`.
* **User Permission**: User `alfa` added to `libvirtd` group.

### Common VMM Commands
```bash
# Launch Virt-Manager GUI (when running start-gui / Hyprland)
virt-manager

# Virsh CLI domain control
virsh list --all
virsh start <vm-name>
virsh shutdown <vm-name>
```
