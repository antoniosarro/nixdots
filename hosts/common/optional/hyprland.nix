{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
  };

  environment.systemPackages = [
    inputs.bibata-modern-amber-hyprcursor.packages.${pkgs.system}.default
  ];
}
