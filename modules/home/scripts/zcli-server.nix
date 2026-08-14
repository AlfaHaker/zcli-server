{
  pkgs,
  profile,
  backupFiles ? [".config/mimeapps.list.backup"],
  ...
}: let
  backupFilesString = pkgs.lib.strings.concatStringsSep " " backupFiles;
in
  pkgs.writeShellScriptBin "zcli-server" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    # --- Program info ---
    # zcli-server - Headless NixOS Server Management CLI
    # ==================================================
    # Version: 1.0.0
    #

    PROJECT="zcli-server"
    PROFILE_DEFAULT="${profile}"
    BACKUP_FILES_STR="${backupFilesString}"
    VERSION="1.0.0"
    FLAKE_NIX_PATH="$HOME/$PROJECT/flake.nix"

    read -r -a BACKUP_FILES <<< "$BACKUP_FILES_STR"

    # --- Helper Functions ---
    get_flake_profile() {
      local flake_profile=""
      if [ -f "$FLAKE_NIX_PATH" ]; then
        flake_profile=$(${pkgs.gnugrep}/bin/grep -E '^[[:space:]]*profile[[:space:]]*=' "$FLAKE_NIX_PATH" | ${pkgs.gnused}/bin/sed 's/.*=[[:space:]]*"\([^"]*\)".*/\1/')
      fi
      echo "$flake_profile"
    }

    verify_hostname() {
      local current_hostname
      local flake_hostname

      current_hostname="$(hostname)"

      if [ -f "$FLAKE_NIX_PATH" ]; then
        flake_hostname=$(${pkgs.gnugrep}/bin/grep -E '^[[:space:]]*host[[:space:]]*=' "$FLAKE_NIX_PATH" | ${pkgs.gnused}/bin/sed 's/.*=[[:space:]]*"\([^"]*\)".*/\1/')

        if [ -z "$flake_hostname" ]; then
          echo "Error: Could not find 'host' variable in $FLAKE_NIX_PATH" >&2
          exit 1
        fi

        if [ "$current_hostname" != "$flake_hostname" ]; then
          echo "Error: Hostname mismatch!" >&2
          echo "  Current hostname: '$current_hostname'" >&2
          echo "  Flake.nix host:   '$flake_hostname'" >&2
          echo "Hint: Run 'zcli-server update-host' to sync" >&2
          exit 1
        fi
      else
        echo "Error: Flake.nix not found at $FLAKE_NIX_PATH" >&2
        exit 1
      fi

      local folder="$HOME/$PROJECT/hosts/$current_hostname"
      if [ ! -d "$folder" ]; then
        echo "Error: Matching host not found in $PROJECT, Missing folder: $folder" >&2
        exit 1
      fi
    }

    print_help() {
      echo "zcli-server Management Utility -- version $VERSION"
      echo ""
      echo "Usage: zcli-server [command] [options]"
      echo ""
      echo "Commands:"
      echo "  rebuild         - Rebuild the NixOS system configuration using zcli-server."
      echo "  rebuild-boot    - Rebuild and set as boot default (activates on next reboot)."
      echo "  update          - Update the flake inputs and rebuild the system."
      echo "  cleanup         - Clean up old system generations."
      echo "  diag            - Create a system diagnostic report."
      echo "  update-host     - Auto set host and profile in flake.nix."
      echo "  help            - Show this help message."
      echo ""
    }

    handle_backups() {
      if [ ''${#BACKUP_FILES[@]} -eq 0 ]; then
        return
      fi

      for file_path in "''${BACKUP_FILES[@]}"; do
        full_path="$HOME/$file_path"
        if [ -f "$full_path" ]; then
          rm "$full_path"
        fi
      done
    }

    parse_nh_args() {
      local args_string=""
      shift

      while [[ $# -gt 0 ]]; do
        case $1 in
          --dry|-n)
            args_string="$args_string --dry"
            shift
            ;;
          --ask|-a)
            args_string="$args_string --ask"
            shift
            ;;
          --verbose|-v)
            args_string="$args_string --verbose"
            shift
            ;;
          *)
            args_string="$args_string $1"
            shift
            ;;
        esac
      done
      echo "$args_string"
    }

    PROFILE="$(get_flake_profile)"
    if [ -z "$PROFILE" ]; then
      PROFILE="$PROFILE_DEFAULT"
    fi

    if [ "$#" -eq 0 ]; then
      print_help
      exit 0
    fi

    case "$1" in
      rebuild)
        verify_hostname
        handle_backups
        extra_args=$(parse_nh_args "$@")
        echo "Starting zcli-server rebuild for host: $(hostname)"
        if eval "${pkgs.nh}/bin/nh os switch --diff always --hostname '$PROFILE' --flake '$HOME/$PROJECT' $extra_args"; then
          echo "✔ Rebuild finished successfully"
        else
          echo "✗ Rebuild Failed" >&2
          exit 1
        fi
        ;;
      rebuild-boot)
        verify_hostname
        handle_backups
        extra_args=$(parse_nh_args "$@")
        echo "Starting zcli-server rebuild (boot) for host: $(hostname)"
        if eval "${pkgs.nh}/bin/nh os boot --diff always --hostname '$PROFILE' --flake '$HOME/$PROJECT' $extra_args"; then
          echo "✔ Rebuild-boot finished successfully"
        else
          echo "✗ Rebuild-boot Failed" >&2
          exit 1
        fi
        ;;
      update)
        verify_hostname
        handle_backups
        extra_args=$(parse_nh_args "$@")
        echo "Updating flake and rebuilding zcli-server..."
        if eval "${pkgs.nh}/bin/nh os switch --diff always --hostname '$PROFILE' --flake '$HOME/$PROJECT' --update $extra_args"; then
          echo "✔ Update finished successfully"
        else
          echo "✗ Update Failed" >&2
          exit 1
        fi
        ;;
      cleanup)
        echo "Cleaning up old system generations..."
        ${pkgs.nh}/bin/nh clean all -v
        ;;
      diag)
        echo "Generating system diagnostic report..."
        ${pkgs.inxi}/bin/inxi --full > "$HOME/zcli-server-diag.txt"
        echo "Diagnostic report saved to $HOME/zcli-server-diag.txt"
        ;;
      help)
        print_help
        ;;
      *)
        echo "Error: Unknown command '$1'" >&2
        print_help
        exit 1
        ;;
    esac
  ''
