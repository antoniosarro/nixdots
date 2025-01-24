{config, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      scrollback_lines = 10000;

      # Font
      font_family = config.hostSpec.theme.font.mono;
      font_size = config.hostSpec.theme.font.size;

      # Theme
      foreground = "#" + config.hostSpec.theme.colors.base05;
      background = "#" + config.hostSpec.theme.colors.base00;
      selection_foreground = "#" + config.hostSpec.theme.colors.base00;
      selection_background = "#" + config.hostSpec.theme.colors.base06;

      cursor = "#" + config.hostSpec.theme.colors.base06;
      cursor_text_color = "#" + config.hostSpec.theme.colors.base00;

      url_color = "#" + config.hostSpec.theme.colors.base06;

      color0 = "#" + config.hostSpec.theme.colors.base03;
      color8 = "#" + config.hostSpec.theme.colors.base04;

      color1 = "#" + config.hostSpec.theme.colors.base08;
      color9 = "#" + config.hostSpec.theme.colors.base08;

      color2 = "#" + config.hostSpec.theme.colors.base0B;
      color10 = "#" + config.hostSpec.theme.colors.base0B;

      color3 = "#" + config.hostSpec.theme.colors.base0A;
      color11 = "#" + config.hostSpec.theme.colors.base0A;

      color4 = "#" + config.hostSpec.theme.colors.base0D;
      color12 = "#" + config.hostSpec.theme.colors.base0D;

      color5 = "#" + config.hostSpec.theme.colors.base0F;
      color13 = "#" + config.hostSpec.theme.colors.base0F;

      color6 = "#" + config.hostSpec.theme.colors.base0C;
      color14 = "#" + config.hostSpec.theme.colors.base0C;

      color7 = "#bac2de";
      color15 = "#a6adc8";

      # Window
      window_padding_width = 5;
    };
  };
}
