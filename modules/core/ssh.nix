{ host, ... }: let
  vars = import ../../hosts/${host}/variables.nix;
  sshEnable = if (vars ? sshEnable) then vars.sshEnable else true;
in {
  services.openssh = {
    enable = sshEnable;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
}
