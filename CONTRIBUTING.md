# 💖 Contributing to `zcli-server`

We are excited that you are interested in contributing to `zcli-server`!

---

## 📜 Code of Conduct

Please adhere to our [Code of Conduct](CODE_OF_CONDUCT.md) when interacting with the community.

---

## 🚀 How to Contribute

### 🐛 Reporting Bugs
If you encounter any issues with `zcli-server`, please open an issue on GitHub.
* Include steps to reproduce the bug.
* Run `nix flake check` or `zcli-server diag` and attach relevant log outputs.

### 💻 Code & Module Contributions
1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Verify your changes pass Nix evaluation:
   ```bash
   nix flake check /path/to/zcli-server
   ```
4. Commit using [Conventional Commits](https://www.conventionalcommits.org/) (e.g. `feat: add new module`, `fix: proxy resolution`).
5. Open a Pull Request to `main`.
