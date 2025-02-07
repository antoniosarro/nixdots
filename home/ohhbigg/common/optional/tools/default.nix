{pkgs, ...}: {
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      # Development
      vscodium-fhs
      sqlitebrowser
      # Device Imaging
      # Productivity
      qbittorrent
      copyq
      drawio
      libreoffice
      obsidian
      # Security
      bitwarden
      # Media
      obs-studio
      freetube
      # VM
      remmina
      # Other
      android-file-transfer
      localsend
      rpi-imager
      nvd
      ;
  };
}
