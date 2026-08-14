{
  pkgs,
  host,
  ...
}: let
  inherit (import ./variables.nix) hostId;
in {
  networking = {
    hostName = "${host}";
    hostId = hostId;
    networkmanager.enable = true;
    timeServers = ["pool.ntp.org"];
    firewall = {
      enable = true;
      trustedInterfaces = [
        "docker0"
        "incusbr0"
        "virbr0"
      ];
      allowedTCPPorts = [
        22     # SSH
        80     # HTTP
        443    # HTTPS
        11434  # Ollama API
      ];
      allowedUDPPorts = [];
    };
  };

  environment.systemPackages = with pkgs; [ networkmanager ];
}
