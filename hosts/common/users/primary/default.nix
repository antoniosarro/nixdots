{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  hostSpec = config.hostSpec;
in
  {
    users.users.${hostSpec.username} = {
      name = hostSpec.username;
      shell = pkgs.zsh;
    };

    systemd.tmpfiles.rules = let
      user = config.users.users.${hostSpec.username}.name;
      group = config.users.users.${hostSpec.username}.group;
    in ["d /home/${hostSpec.username}/.ssh/sockets 0750 ${user} ${group} -"];

    programs.zsh.enable = true;
    environment.systemPackages = [
      pkgs.just
      pkgs.rsync
    ];
  }
  // lib.optionalAttrs (inputs ? "home-manager") {
    home-manager = {
      extraSpecialArgs = {
        inherit pkgs inputs;
        hostSpec = config.hostSpec;
      };
      users.${hostSpec.username}.imports = lib.flatten [
        (
          {config, ...}:
            import (lib.custom.relativeToRoot "home/${hostSpec.username}/${hostSpec.hostName}.nix") {
              inherit
                pkgs
                inputs
                config
                lib
                hostSpec
                ;
            }
        )
      ];
    };
  }
