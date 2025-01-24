{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  ...
}: let
  platform = "nixos";
  platformModules = "${platform}Modules";
in {
  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager

    (map lib.custom.relativeToRoot [
      "modules/common"
      "modules/${platform}"
      "hosts/common/core/${platform}.nix"
      "hosts/common/users/primary"
      "hosts/common/users/primary/${platform}.nix"
    ])
  ];

  hostSpec = {
    username = "ohhbigg";
    handle = "antoniosarro";
    email = {
      github = "tech@antoniosarro.dev";
    };
    theme = import ../theme;
  };

  networking.hostName = config.hostSpec.hostName;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "bk";

  nixpkgs = {
    overlays = [
      outputs.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # See https://jackson.dev/post/nix-reasonable-defaults/
    settings = {
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = ["@wheel"];

      auto-optimise-store = true;
      warn-dirty = false;

      allow-import-from-derivation = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };
}
