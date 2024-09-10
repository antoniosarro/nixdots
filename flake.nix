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

    # hyprland tiling Wayland compositor.
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # apple fonts.
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
  };

  outputs = inputs @ {nixpkgs, ...}: {
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
  };
}
