{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./chromium.nix
    ./firefox.nix
  ];

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${pkgs.system}".beta
  ];
}
