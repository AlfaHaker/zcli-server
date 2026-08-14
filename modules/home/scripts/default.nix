{
  config,
  pkgs,
  username,
  profile,
  ...
}: {
  home.packages = [
    (import ./hm-find.nix {inherit pkgs;})
    (import ./note.nix {inherit pkgs;})
    (import ./note-from-clipboard.nix {inherit pkgs;})
    (import ./nvidia-offload.nix {inherit pkgs;})
    (import ./rofi-launcher.nix {inherit pkgs;})
    (import ./screenshootin.nix {inherit pkgs;})
    (import ./squirtle.nix {inherit pkgs;})
    (import ./web-search.nix {inherit pkgs;})
    (import ./cheatsheets-parser.nix {inherit pkgs;})
    (import ./docs-parser.nix {inherit pkgs;})
    (import ./hyprland-float-all.nix {inherit pkgs;})
    (import ./hyprland-change-layout.nix {inherit pkgs;})
    (import ./start-gui.nix {inherit pkgs;})
    (import ./zcli-server.nix {
      inherit pkgs profile;
      backupFiles = [
        ".config/mimeapps.list.backup"
      ];
    })
  ];
}
