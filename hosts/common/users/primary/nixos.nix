{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  hostSpec = config.hostSpec;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
  {
    users.mutableUsers = false;
    users.users.${hostSpec.username} = {
      home = "/home/${hostSpec.username}";
      isNormalUser = true;
      hashedPassword = "$y$j9T$fWn4.HzmsT7aryHo34PfC.$wlH3KX5.fdTztxgS8kYNCOTqD1RcebdP0S6q1Z4kT77";

      extraGroups = lib.flatten [
        "wheel"
        (ifTheyExist [
          "audio"
          "video"
          "docker"
          "git"
          "networkmanager"
          "scanner"
          "lp"
        ])
      ];
    };

    programs.git.enable = true;

    users.users.root = {
      shell = pkgs.zsh;
      hashedPassword = "$y$j9T$fWn4.HzmsT7aryHo34PfC.$wlH3KX5.fdTztxgS8kYNCOTqD1RcebdP0S6q1Z4kT77";
      openssh.authorizedKeys.keys = config.users.users.${hostSpec.username}.openssh.authorizedKeys.keys;
    };
  }
  // {
    home-manager.users.root = {
      home.stateVersion = "24.11";
      programs.zsh = {
        enable = true;
      };
    };
  }
