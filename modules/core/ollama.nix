{ host, ... }: let
  vars = import ../../hosts/${host}/variables.nix;
  ollamaEnable = if (vars ? ollamaEnable) then vars.ollamaEnable else true;
  ollamaModelsDir = if (vars ? ollamaModelsDir) then vars.ollamaModelsDir else "/var/lib/ollama";
in {
  services.ollama = {
    enable = ollamaEnable;
    modelsDir = ollamaModelsDir;
  };
}
