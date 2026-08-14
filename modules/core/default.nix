{
  inputs,
  host,
  ...
}: let
  vars = import ../../hosts/${host}/variables.nix;
in {
  imports = [
    ./boot.nix
    ./flatpak.nix
    ./fonts.nix
    ./hardware.nix
    ./hyprland.nix
    ./keepass.nix
    ./nfs.nix
    ./nh.nix
    ./ollama.nix
    ./packages.nix
    ./printing.nix
    ./security.nix
    ./services.nix
    ./ssh.nix
    ./steam.nix
    ./stylix.nix
    ./syncthing.nix
    ./zellij.nix
    ./virtualisation.nix
    ./ly.nix
    ./system.nix
    ./thunar.nix
    ./user.nix
    ./xserver.nix
    ./cachix.nix
    inputs.stylix.nixosModules.stylix
  ] ++ (
    if (vars ? mpdEnable && vars.mpdEnable)
    then [ ./mpd.nix ]
    else []
  );
}
