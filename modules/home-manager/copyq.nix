{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.copyq;
  configDir = "${config.xdg.configHome}/copyq";
in {
  options.programs.copyq = {
    enable = lib.mkEnableOption "copyq";
    package = lib.mkPackageOption pkgs "copyq" {};

    settings = {
      Options = {
        close_on_unfocus = false;
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [cfg.package];
    home.file = {
      "${configDir}/copyq.conf" = lib.mkIf (cfg.settings != {}) lib.generators.toINI {} cfg.settings;
    };
  };
}
