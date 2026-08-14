{ host, pkgs, ... }: let
  vars = import ../../hosts/${host}/variables.nix;
  hyprlandEnable = if (vars ? hyprlandEnable) then vars.hyprlandEnable else true;
in {
  programs.hyprland = {
    enable = hyprlandEnable;
    xwayland.enable = true;
  };
}
