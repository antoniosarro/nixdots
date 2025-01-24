{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.adi1090x-plymouth-themes];
  boot = {
    kernelParams = [
      "quiet"
    ];
    plymouth = {
      enable = true;
      theme = lib.mkForce "hexagon_dots_alt";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {selected_themes = ["hexagon_dots_alt"];})
      ];
    };
    consoleLogLevel = 0;
  };
}
