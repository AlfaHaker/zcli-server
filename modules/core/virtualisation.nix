{ host, username, pkgs, ... }: let
  vars = import ../../hosts/${host}/variables.nix;

  dockerEnable = if (vars ? dockerEnable) then vars.dockerEnable else true;
  incusEnable = if (vars ? incusEnable) then vars.incusEnable else false;
  lxcEnable = if (vars ? lxcEnable) then vars.lxcEnable else false;
  vmmEnable = if (vars ? vmmEnable) then vars.vmmEnable else false;
  podmanEnable = if (vars ? podmanEnable) then vars.podmanEnable else false;
  vboxEnable = if (vars ? vboxEnable) then vars.vboxEnable else false;

  dockerDataRoot = if (vars ? dockerDataRoot) then vars.dockerDataRoot else "/var/lib/docker";

  extraGroups = (if dockerEnable then ["docker"] else [])
    ++ (if incusEnable then ["incus-admin"] else [])
    ++ (if vmmEnable then ["libvirtd"] else [])
    ++ (if vboxEnable then ["vboxusers"] else []);
in {
  virtualisation = {
    docker = {
      enable = dockerEnable;
      enableOnBoot = dockerEnable;
      daemon.settings = {
        data-root = dockerDataRoot;
      };
    };
    podman.enable = podmanEnable;
    incus.enable = incusEnable;
    lxc.enable = lxcEnable;

    libvirtd = {
      enable = vmmEnable;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    virtualbox.host = {
      enable = vboxEnable;
      enableExtensionPack = true;
    };
  };

  programs.virt-manager.enable = vmmEnable;

  users.users.${username}.extraGroups = extraGroups;

  environment.systemPackages = (if dockerEnable then [ pkgs.lazydocker pkgs.docker-client ] else [])
    ++ (if lxcEnable then [ pkgs.lxc ] else [])
    ++ (if vmmEnable then with pkgs; [ virt-manager virt-viewer qemu_kvm libvirt ] else []);
}
