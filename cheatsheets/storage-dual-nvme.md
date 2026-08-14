# Dual NVMe Storage Architecture Guide

Reference for host `OldMan` multi-drive NVMe storage configuration and workload redirection.

---

## 💾 Storage Layout (`OldMan`)

* **Primary NVMe (`nvme1n1` - 238GB)**:
  * `/boot` (EFI Bootloader)
  * `/` (Root Ext4 Filesystem & `/nix/store`)
  * `swap` (24GB Swap partition)
* **Secondary NVMe (`nvme0n1` - 119GB)**:
  * Mounted at `/mnt/nvme-storage` (Btrfs with async TRIM and compression).
  * Stores Docker container volumes (`/mnt/nvme-storage/docker`).
  * Stores Ollama AI models (`/mnt/nvme-storage/ollama`).
  * Stores Incus container data (`/var/lib/incus` bind-mounted to `/mnt/nvme-storage/incus`).

---

## ⚙️ How Workloads Are Redirected

### 1. Docker `data-root`
In `hosts/OldMan/variables.nix`:
```nix
dockerDataRoot = "/mnt/nvme-storage/docker";
```
Docker automatically writes all container layers, volumes, and images directly to the second NVMe drive.

### 2. Ollama `modelsDir`
In `hosts/OldMan/variables.nix`:
```nix
ollamaModelsDir = "/mnt/nvme-storage/ollama";
```
Downloaded AI models (e.g. `ollama run llama3`) are stored directly on the second NVMe drive.

### 3. Incus Bind-Mount
In `hosts/OldMan/hardware.nix`:
```nix
"/var/lib/incus" = {
  device = "/mnt/nvme-storage/incus";
  fsType = "none";
  options = [ "bind" "nofail" ];
};
```
Incus container instances and storage pools automatically store images and volumes on the second NVMe drive.
