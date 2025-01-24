{
  pkgs,
  lib,
  config,
  ...
}: let
  handle = config.hostSpec.handle;
  publicGitEmail = config.hostSpec.email.github;
in {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = handle;
    userEmail = publicGitEmail;
    aliases = {};
    extraConfig = {
      log.showSignature = "true";
      init.defaultBranch = "main";
      pull.rebase = "true";
      push.autoSetupRemote = true;
    };
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "*.elc"
      "auto-save-list"
      ".direnv/"
      "node_modules"
      "result"
      "result-*"
    ];
  };
}
