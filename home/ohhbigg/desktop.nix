{ config, ... }:
{
  imports = [
    # ============================
    # Hardware Required Configs
    # ============================
    common/core

    # ============================
    # Host-specific Configs
    # ============================
    common/optional/browsers
    common/optional/desktops
    common/optional/dev
    common/optional/comms
    common/optional/gaming
    common/optional/media
    common/optional/tools
    common/optional/scripts
  ];

  monitors = [
    {
      name = "DP-2";
      width = 3440;
      height = 1440;
      refreshRate = 120;
      primary = true;
    }
  ];

  home.file."${config.home.homeDirectory}/media/images/wallpapers" = {
    recursive = true;
    source = ../../wallpapers;
  };
}
