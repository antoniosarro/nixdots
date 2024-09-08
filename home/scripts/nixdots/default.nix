{
  pkgs,
  config,
  ...
}: let
  nixdots = pkgs.writeShellScriptBin "nixdots" ''
    if [[ $1 == "rebuild" ]];then
      sudo nixos-rebuild switch --flake ${config.var.configDirectory}#${config.var.hostname}
    elif [[ $1 == "upgrade" ]];then
      sudo nixos-rebuild switch --upgrade --flake ${config.var.configDirectory}#${config.var.hostname}
    elif [[ $1 == "update" ]];then
      cd ${config.var.configDirectory} && sudo nix flake update
    elif [[ $1 == "gc" ]];then
      cd ${config.var.configDirectory} && sudo nix-collect-garbage -d
    elif [[ $1 == "cb" ]];then
      sudo /run/current-system/bin/switch-to-configuration boot
    else
      echo "Unknown argument"
    fi
  '';
in {home.packages = [nixdots];}
