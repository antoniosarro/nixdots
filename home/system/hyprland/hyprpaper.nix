{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["$HOME/wallpapers/${config.var.theme.wallpaper.base}"];
      wallpaper = [",$HOME/wallpapers/${config.var.theme.wallpaper.base}"];
    };
  };
}
