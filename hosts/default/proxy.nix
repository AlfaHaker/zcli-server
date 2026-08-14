{ host, ... }: let
  vars = import ./variables.nix;
  proxyEnable = if (vars ? proxyEnable) then vars.proxyEnable else false;
in {
  services.caddy = {
    enable = proxyEnable;
    virtualHosts = {
      "ai.${host}".extraConfig = ''
        reverse_proxy 127.0.0.1:11434
      '';
    };
  };

  networking.firewall.allowedTCPPorts = if proxyEnable then [ 80 443 ] else [];
}
