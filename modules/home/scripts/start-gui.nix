{ pkgs, ... }:
pkgs.writeShellScriptBin "start-gui" ''
  #!${pkgs.bash}/bin/bash
  echo "Launching Hyprland GUI..."
  exec Hyprland
''
