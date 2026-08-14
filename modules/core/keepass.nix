{ host, pkgs, ... }: let
  vars = import ../../hosts/${host}/variables.nix;
  keepassEnable = if (vars ? keepassEnable) then vars.keepassEnable else true;
in {
  environment.systemPackages = if keepassEnable then [
    pkgs.keepassxc
    pkgs.kpcli
  ] else [];
}
