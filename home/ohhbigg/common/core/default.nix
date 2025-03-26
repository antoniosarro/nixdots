{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}:
let
  platform = "nixos";
in
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-spec.nix"
      "modules/home-manager"
    ])
    ./${platform}.nix
    ./neovim
    ./shell
    ./fonts.nix
    ./git.nix
    ./kitty.nix
    ./xdg.nix
  ];

  inherit hostSpec;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "24.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/nixdots";
      SHELL = "zsh";
      TERM = "kitty";
      TERMINAL = "kitty";
      VISUAL = "nvim";
      EDITOR = "nvim";
      MANPAGER = "batman";
    };
    preferXdgDirectories = true;
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)
      coreutils # basic gnu utils
      dust # disk usage
      jq # JSON pretty printer and manipulator
      ncdu # TUI disk usage
      pre-commit # git hooks
      p7zip # compression & encryption
      steam-run # for running non-NixOS-packaged binaries on Nix
      unzip # zip extraction
      unrar # rar extraction
      zip # zip compression
      ;
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
