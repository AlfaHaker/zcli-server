# Caddy Reverse Proxy Cheatsheet

Complete reference for configuring Caddy in `zcli-server` to route traffic to Docker containers, Incus instances, and native NixOS services.

---

## 🌐 Location of Proxy Rules
Proxy rules are configured per host inside **[hosts/<hostname>/proxy.nix](file:///home/alfa/zcli-server/hosts/OldMan/proxy.nix)**.

---

## 1. Subdomain Format (`app.hostname`)

Route services using subdomains (e.g. `odoo.OldMan`, `ai.OldMan`, `app.192.168.2.7.nip.io`):

```nix
services.caddy.virtualHosts = {
  # odoo.OldMan -> Docker container port 8069
  "odoo.${host}".extraConfig = ''
    reverse_proxy 127.0.0.1:8069
  '';

  # ai.OldMan -> Native Ollama AI service
  "ai.${host}".extraConfig = ''
    reverse_proxy 127.0.0.1:11434
  '';

  # Wildcard LAN Domain via nip.io (works on any device on Wi-Fi without editing /etc/hosts)
  "odoo.192.168.2.7.nip.io".extraConfig = ''
    reverse_proxy 127.0.0.1:8069
  '';
};
```

---

## 2. Path Format (`hostname/app`)

Route services by URL subpath (e.g. `http://OldMan/odoo` or `http://OldMan/ai`). Uses `handle_path` to automatically strip the path prefix before forwarding to the container:

```nix
services.caddy.virtualHosts = {
  "${host}".extraConfig = ''
    handle_path /odoo/* {
      reverse_proxy 127.0.0.1:8069
    }

    handle_path /ai/* {
      reverse_proxy 127.0.0.1:11434
    }
  '';
};
```

---

## 3. Password Protection (`basic_auth`)

Add password protection in front of any service:

Generate password hash:
```bash
caddy hash-password
```

Add to `proxy.nix`:
```nix
"secure.${host}".extraConfig = ''
  basic_auth {
    admin $2a$14$Zkx19X3...
  }
  reverse_proxy 127.0.0.1:8080
'';
```

---

## 4. Local LAN Only Restriction (`remote_ip`)

Restrict access to your local network (`192.168.2.0/24`):
```nix
"private.${host}".extraConfig = ''
  @denied not remote_ip 192.168.2.0/24 127.0.0.1
  respond @denied "Access Denied" 403

  reverse_proxy 127.0.0.1:8080
'';
```
