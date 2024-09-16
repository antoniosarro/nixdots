{
  config,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      # Font
      font_family = config.var.theme.font.mono;
      font_size = config.var.theme.font.size;

      #Theme
      background = "#" + config.var.theme.colors.background;
      url_color = "#" + config.var.theme.colors.accent;
      color0 = "#" + "1e1e2e";
      color8 = "#" + "313244";
      color1 = "#" + "f38ba8";
      color9 = "#" + "eba0ac";
      color2 = "#" + "a6e3a1";
      color10 = "#" + "94e2d5";
      color3 = "#" + "fab387";
      color11 = "#" + "f9e2af";
      color4 = "#" + "89b4fa";
      color12 = "#" + "b4befe";
      color5 = "#" + "A594FD";
      color13 = "#" + "f5c2e7";
      color6 = "#" + "74c7ec";
      color14 = "#" + "94e2d5";
      color7 = "#" + "cdd6f4";
      color15 = "#" + "bac2de";
      cursor = "#" + config.var.theme.colors.text;
      cursor_text_color = "#" + config.var.theme.colors.background;
      selection_foreground = "#" + config.var.theme.colors.background;
      selection_background = "#" + config.var.theme.colors.accent;

      # Window
      window_padding_width = 5;
    };
  };
}
