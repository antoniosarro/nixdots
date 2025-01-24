{pkgs, ...}: {
  imports = [
    ./spotify.nix
  ];

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      ;
  };
}
