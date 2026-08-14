{...}: {
  imports = [
    ./hardware.nix
    ./host-packages.nix
    ./network.nix
    ./proxy.nix
  ];
}
