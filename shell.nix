# This shell.nix is used for bootstrapping a new NixOS system.
# It provides the minimal necessary tools to get started:
# - nix with flakes support
# - home-manager for user configuration
# - sops/age for secret management
# - git and just for basic development needs
{
  pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  checks,
  ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";

    inherit (checks.pre-commit-check) shellHook;
    buildInputs = checks.pre-commit-check.enabledPackages;

    nativeBuildInputs = builtins.attrValues {
      inherit
        (pkgs)
        nix
        home-manager
        git
        just
        age
        ssh-to-age
        sops
        ;
    };
  };
}
