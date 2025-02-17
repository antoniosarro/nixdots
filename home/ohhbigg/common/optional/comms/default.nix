{pkgs, ...}: {
  imports = [
    ./vesktop.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      element-desktop
      protonmail-desktop
      signal-desktop
      slack
      teams-for-linux
      telegram-desktop
      ;
  };
}
