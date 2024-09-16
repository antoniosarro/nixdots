{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  home.packages = with pkgs; [sops age];

  sops = {
    age.keyFile = "/home/${config.var.username}/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "private_keys/github" = {
        path = "/home/${config.var.username}/.ssh/github";
      };
    };
  };

  systemd.user.services.mbsync.Unit.After = ["sops-nix.service"];
}
