{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 5;
      };
      background = {
        monitor = "";
        path = "$HOME/wallpapers/${config.var.theme.wallpaper.blur}";
      };
      input-field = {
        monitor = "";
        size = "250, 50";
        outline_thickness = 1;
        dots_size = 0.2;
        dots_spacing = 0.15;
        dots_center = true;
        outer_color = "rgb(222, 99, 65)";
        inner_color = "rgb(31, 31, 40)";
        font_color = "rgb(222, 99, 65)";
        fade_on_empty = true;
        fade_timeout = 1000;
        placeholder_text = "<i>Input Password...</i>";
        check_color = "rgb(186, 84, 56)";
        fail_color = "rgb(199, 58, 58)";
        position = "0, -20";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date '+%A, %B %d, %Y')"'';
          color = "rgb(222, 99, 65)";
          font_size = 20;
          font_family = config.var.theme.font.base;
          position = "-100, 160";
          halign = "right";
          valign = "bottom";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date '+%r')"'';
          color = "rgb(222, 99, 65)";
          font_size = 30;
          font_family = config.var.theme.font.base;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$USER";
          color = "rgb(222, 99, 65)";
          font_size = 20;
          font_family = config.var.theme.font.base;
          position = "-100, 120";
          halign = "right";
          valign = "bottom";
        }
      ];
      image = {
        monitor = "";
        path = "$HOME/wallpapers/profile.png";
        size = 150;
        rounding = -1;
        border_size = 1;
        border_color = "rgb(222, 99, 65)";
        rotate = 0;
        reload_time = -1;
        position = "0, 200";
        halign = "center";
        valign = "center";
      };
    };
  };
}
