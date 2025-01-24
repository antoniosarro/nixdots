{
  pkgs,
  config,
  ...
}: {
  home.packages = builtins.attrValues {
    inherit (pkgs) libnotify;
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
      size = "16x16";
    };
    settings = {
      global = {
        allow_markup = "yes";
        format = "%I %s %p\n%b";
        alignment = "left";
        sort = "yes";
        indicate_hidden = "yes";
        bounce_freq = 5;
        show_age_threshold = 60;
        word_wrap = "no";
        ignore_newline = "no";
      };
    };
  };
}
