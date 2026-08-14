{ pkgs, ... }: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false; # Manual launch as requested
  };

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
}
