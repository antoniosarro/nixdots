{config, ...}: {
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
    common/optional/comms
    common/optional/gaming
    common/optional/media
    common/optional/tools
    common/optional/scripts
  ];

  monitors = [
    {
      name = "eDP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      primary = true;
    }
  ];

  home.file."${config.home.homeDirectory}/media/images/wallpapers" = {
    recursive = true;
    source = ../../wallpapers;
  };
}
