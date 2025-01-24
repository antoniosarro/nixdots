{
  description = "Antonio Sarro's Nix-Config";

  inputs = {
    # ===============================
    # NixOS and Home Manager sources
    # ===============================
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ===============================
    # Utilities
    # ===============================

    # Collection of NixOS modules covering hardware quirks
    hardware.url = "github:nixos/nixos-hardware";

    # Declarative partitioning and formatting
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management.
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spotify customization
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pre commit hooks
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming
    bibata-modern-amber-hyprcursor.url = "github:antoniosarro/bibata-modern-amber-hyprcursor";
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs) lib;

    #
    # ========= Architectures =========
    #
    architectures = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      #"aarch64-darwin"
    ];
    #
    # ========= Host Config Functions =========
    #
    mkHost = host: {
      ${host} = let
        func = lib.nixosSystem;
        systemFunc = func;
      in
        systemFunc {
          specialArgs = {
            inherit
              inputs
              outputs
              ;
            lib = nixpkgs.lib.extend (self: super: {custom = import ./lib {inherit (nixpkgs) lib;};});
          };
          modules = [./hosts/nixos/${host}];
        };
    };
    mkHostConfigs = hosts: lib.foldl (acc: set: acc // set) {} (lib.map (host: mkHost host) hosts);
    readHosts = folder: lib.attrNames (builtins.readDir ./hosts/${folder});
  in {
    #
    # ========= Overlays =========
    #
    # Custom modifications/overrides to upstream packages.
    overlays = import ./overlays {inherit inputs;};

    #
    # ========= Host Configurations =========
    #
    # `just rebuild` or `nixos-rebuild --flake .#hostname`
    nixosConfigurations = mkHostConfigs (readHosts "nixos");

    #
    # ========= Packages =========
    #
    # Add custom packages to be shared or upstreamed.
    packages = architectures (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
        };
      in
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith pkgs;
          directory = ./pkgs/common;
        }
    );

    # ========= Formatting and Checks =========
    #
    # Nix formatter available through 'nix fmt'.
    formatter = architectures (system: nixpkgs.legacyPackages.${system}.alejandra);
    checks = architectures (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./checks {inherit inputs system pkgs;}
    );

    # ========= DevShell =========
    #
    # Custom shell for bootstrapping on new hosts, modifying nix-config, and secrets management
    devShells = architectures (
      system:
        import ./shell.nix {
          pkgs = nixpkgs.legacyPackages.${system};
          checks = self.checks.${system};
        }
    );
  };
}
