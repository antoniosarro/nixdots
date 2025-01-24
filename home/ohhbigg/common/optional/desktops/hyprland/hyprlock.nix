{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 5;
        hide_cursor = true;
      };
      background = {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      };
      input-field = {
        monitor = "";
        size = "250, 50";
        outline_thickness = 1;
        dots_size = 0.2;
        dots_spacing = 0.15;
        dots_center = true;
        outer_color = "rgb(${config.hostSpec.theme.colors.base03})";
        inner_color = "rgb(${config.hostSpec.theme.colors.base00})";
        font_color = "rgb(${config.hostSpec.theme.colors.base05})";
        fade_on_empty = true;
        fade_timeout = 1000;
        placeholder_text = "<i>Input Password...</i>";
        check_color = "rgb(${config.hostSpec.theme.colors.base08})";
        fail_color = "rgb(${config.hostSpec.theme.colors.base0A})";
        position = "0, -20";
        halign = "center";
        valign = "center";
      };
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date '+%A, %B %d, %Y')"'';
          color = "rgb(${config.hostSpec.theme.colors.base05})";
          font_size = 20;
          font_family = config.hostSpec.theme.font.base;
          position = "-100, 160";
          halign = "right";
          valign = "bottom";
        }
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date '+%r')"'';
          color = "rgb(${config.hostSpec.theme.colors.base05})";
          font_size = 30;
          font_family = config.hostSpec.theme.font.base;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$USER";
          color = "rgb(${config.hostSpec.theme.colors.base05})";
          font_size = 20;
          font_family = config.hostSpec.theme.font.base;
          position = "-100, 120";
          halign = "right";
          valign = "bottom";
        }
      ];
    };
  };
}
