{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${config.home.homeDirectory}/media/images/wallpapers/1.jpeg"];
      wallpaper = [",${config.home.homeDirectory}/media/images/wallpapers/1.jpeg"];
    };
  };
}
