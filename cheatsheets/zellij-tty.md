# Zellij & TTY Experience Cheatsheet

Reference guide for the **Zellij** terminal multiplexer, TTY polish, KeePass tools, and on-demand GUI launching in `zcli-server`.

---

## ⚡ 1. Zellij Terminal Multiplexer (`tmux` Alternative)

Launch Zellij anytime by typing:
```bash
z
# or
zellij
```

### Essential Shortcuts

| Action | Shortcut |
| :--- | :--- |
| **New Pane Right** | `Alt + n` |
| **New Pane Down** | `Alt + d` |
| **Move Focus** | `Alt + ← ↓ ↑ →` or `Alt + h j k l` |
| **Toggle Floating Pane** | `Alt + f` |
| **New Tab** | `Alt + t` |
| **Switch Tabs** | `Alt + 1..9` |
| **Close Current Pane** | `Alt + x` |
| **Detach Session** | `Alt + d` (in session mode) |
| **Lock/Unlock Keys** | `Alt + z` |

---

## 🔑 2. KeePass Password Managers

* **`kpcli`**: Interactive command-line shell for `.kdbx` password databases in TTY:
  ```bash
  kpcli --kdb passwords.kdbx
  ```
* **`keepassxc-cli`**: CLI tool for quick querying:
  ```bash
  keepassxc-cli show passwords.kdbx "My Entry"
  ```
* **`keepassxc`**: Graphical GUI application available when Hyprland is active.

---

## 🖥️ 3. On-Demand Hyprland GUI Launch

`zcli-server` boots strictly to TTY text mode for maximum speed and zero background GUI overhead.

When you need the graphical desktop, launch it manually from TTY:
```bash
start-gui
# or
Hyprland
```

* **GUI Apps Included**: Zen Browser (`zen-browser`), KeePassXC (`keepassxc`), Kitty terminal, and Hyprland window manager.
