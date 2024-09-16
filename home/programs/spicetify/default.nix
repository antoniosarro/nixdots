{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) ["spotify"];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "custom";

    customColorScheme = {
      accent = config.var.theme.colors.accent;
      accent-active = config.var.theme.colors.accent;
      accent-inactive = "121212";
      banner = config.var.theme.colors.accent;
      border-active = config.var.theme.colors.accent;
      border-inactive = "535353";
      header = "535353";
      highlight = "1a1a1a";
      main = "121212";
      notification = "4687d6";
      notification-error = "e22134";
      subtext = "b3b3b3";
      text = "FFFFFF";
    };

    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      historyShortcut
      hidePodcasts
      adblock
      fullAppDisplay
      shuffle
    ];
  };
}
