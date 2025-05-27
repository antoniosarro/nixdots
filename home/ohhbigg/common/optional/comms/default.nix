{ pkgs, ... }:
{
  imports = [
    ./vesktop.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      element-desktop
      protonmail-desktop
      signal-desktop
      slack
      telegram-desktop
      ;
    inherit (pkgs.unstable)
      teams-for-linux
      ;
  };

}
