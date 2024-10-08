{
  description = ''
    NixOS configurations with flakes and home-manager for my personal setup.
  '';

  inputs = {
    # unstable NixOS nixpkgs package set.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager, used for managing user configuration.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # disko, used for managing disk partitioning.
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # apple fonts.
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs = inputs @ {nixpkgs, ...}: let
    allSystems = ["x86_64-linux"];

    forAllSystems = fn:
      nixpkgs.lib.genAttrs allSystems
      (system: fn {pkgs = import nixpkgs {inherit system;};});
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            _module.args = {inherit inputs;};
          }
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          ./hosts/laptop/configuration.nix
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            _module.args = {inherit inputs;};
          }
          inputs.disko.nixosModules.disko
          inputs.home-manager.nixosModules.home-manager
          ./hosts/desktop/configuration.nix
        ];
      };
    };
    devShells = forAllSystems ({pkgs}: {
      golang_latest = pkgs.mkShell {
        shellHook = ''
          $SHELL
        '';
        packages = with pkgs; [
          go
          gotools
          golangci-lint
        ];
      };
    });
  };
}
