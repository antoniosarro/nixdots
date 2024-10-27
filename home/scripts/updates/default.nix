{pkgs, ...}: let
  update-check = pkgs.writeShellScriptBin "update-check" ''
    set -eo pipefail

    cleanup() {
      rm -r /tmp/tmp.nix-updateinfo.*
    }
    trap cleanup EXIT

    tempdir=$(mktemp -d /tmp/tmp.nix-updateinfo.XXX)
    parameter="$1"

    git clone --reference ~/.config/nixdots ~/.config/nixdots "$tempdir"
    cd "$tempdir"
    nix flake lock --update-input nixpkgs
    nix build ".#nixosConfigurations.desktop.config.system.build.toplevel"

    if [[ "$parameter" == "pretty" ]]; then
      nvd diff /run/current-system ./result
    else
      updates="$(nvd diff /run/current-system ./result | grep -c '\[U')"
      if [ "$updates" != 0 ]; then
          alt="has-updates"
          tooltip=$(nvd diff /run/current-system ./result | grep '\[U' | awk '{ for (i=3; i<NF; i++) printf $i " "; if (NF >= 3) print $NF; }' ORS='\\n')
          echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\",\"class\": \"active\" }"
      else
          alt="updated"
          tooltip="System updated"
          echo "{ \"text\":\"$updates\", \"alt\":\"$alt\", \"tooltip\":\"$tooltip\" }"
      fi
    fi

    cd ~-
    rm -rf "$tempdir"
  '';
in {home.packages = [update-check];}
