# NixOS & Flakes Quick Reference

Essential guide for managing NixOS configurations, editing host options, and performing system rollbacks.

---

## 🛠️ System Maintenance

```bash
# Rebuild and apply configuration changes
zcli-server rebuild

# Rebuild for next boot (useful when updating kernel/boot options)
zcli-server rebuild-boot

# Update flake locks (nixpkgs & inputs) and rebuild
zcli-server update

# Clean old generations to free up disk space
zcli-server cleanup
```

---

## 🔄 System Rollback (If a Rebuild Breaks)

If a new system configuration breaks, you can easily roll back:

1. **Boot Menu Rollback**: Reboot your system, select an earlier working NixOS generation in the bootloader menu, and hit Enter.
2. **CLI Rollback**:
   ```bash
   sudo nixos-rebuild switch --rollback
   ```

---

## 📂 Key File Locations

| File | Purpose |
| :--- | :--- |
| `flake.nix` | System inputs, nixpkgs channels, and system output definitions. |
| `hosts/OldMan/variables.nix` | Service switches (`dockerEnable`, `sshEnable`, `ollamaEnable`, `proxyEnable`) and host variables. |
| `hosts/OldMan/network.nix` | Hostname, static IP (`192.168.2.7`), firewall ports, and trusted interfaces. |
| `hosts/OldMan/hardware.nix` | Filesystems, disk mounts (`/mnt/nvme-storage`), and CPU microcode. |
| `hosts/OldMan/proxy.nix` | Caddy reverse proxy rules (`app.hostname`, `hostname/app`). |
| `modules/core/` | Modular single-service `.nix` system files. |
| `modules/home/` | User environment, shell aliases, Zellij, and CLI packages. |
