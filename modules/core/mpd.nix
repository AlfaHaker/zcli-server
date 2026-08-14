{
  config,
  username,
  host,
  ...
}: let
  # Import the host-specific variables.nix
  vars = import ../../hosts/${host}/variables.nix;
in {
  services.mpd = {
    enable = true;
    user = "${username}";
    musicDirectory = vars.mpdMusicDir;
    settings.audio_output = [
      {
        type = "pipewire";
        name = "pipewire";
      }
    ];
  };
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${username}.uid}";
  };
}
