{ host, pkgs, ... }: let
  vars = import ../../hosts/${host}/variables.nix;
  zellijEnable = if (vars ? zellijEnable) then vars.zellijEnable else true;
in {
  environment.systemPackages = if zellijEnable then [ pkgs.zellij ] else [];
}
