# Yazi TTY File Manager Cheatsheet

**Yazi** is a blazingly fast, Rust-based terminal file manager with async I/O, image previews, and modal keybindings built into `zcli-server`.

---

## ⚡ Launch Command

Launch Yazi anytime from TTY:
```bash
yazi
# or alias
y
```

---

## 🧭 1. Navigation & Movement

| Key | Action |
| :--- | :--- |
| `h` / `←` | Go to parent directory |
| `j` / `↓` | Move selection down |
| `k` / `↑` | Move selection up |
| `l` / `→` / `Enter` | Enter directory / Open file |
| `gg` | Jump to top of directory |
| `G` | Jump to bottom of directory |
| `Ctrl + f` | Page down |
| `Ctrl + b` | Page up |
| `~` | Toggle internal keybindings help menu |

---

## 📂 2. File Operations

| Key | Action |
| :--- | :--- |
| `Space` | Toggle single file selection |
| `v` | Enter visual selection mode |
| `a` | Create a new file or directory (end with `/` for folder) |
| `r` | Rename file or directory |
| `y` | Copy (Yank) selected items |
| `x` | Cut selected items |
| `p` | Paste copied/cut items |
| `d` | Move selected items to trash |
| `D` | Delete selected items permanently |
| `Ctrl + c` | Cancel current selection/operation |

---

## 🔍 3. Searching, Filtering & Zoxide Jump

| Key | Action |
| :--- | :--- |
| `/` | Search file names in current directory |
| `f` | Filter file names dynamically |
| `z` | Jump to frequent directories via **Zoxide** integration |
| `.` | Toggle hidden files and dotfiles (`.config`, etc.) |

---

## 📑 4. Tab Management

| Key | Action |
| :--- | :--- |
| `t` | Open a new tab |
| `1` .. `9` | Switch directly to tab `1` through `9` |
| `w` | Close current tab |
| `[` / `]` | Switch to previous / next tab |

---

## 📊 5. Sorting & Layout

| Key | Action |
| :--- | :--- |
| `,` | Open sorting menu (sort by name, size, modified time, extension) |
| `Ctrl + h` | Toggle hidden file visibility |
