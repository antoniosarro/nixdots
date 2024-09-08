{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprcursor
  ];

  home.file.".icons" = {
    recursive = true;
    source = ./cursor/Bibata-Modern-Amber;
  };
}
