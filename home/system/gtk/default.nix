{
  config,
  pkgs,
  ...
}: {
  qt = {
    enable = true;
    platformTheme.name = "gtk2";
    style.name = "gtk2";
  };

  gtk = {
    enable = true;

    theme = {name = "FlatColor";};

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    font = {
      name = config.var.theme.font.base;
      size = config.var.theme.font.size;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = FlatColor:dark;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 14;
  };

  home.file = {
    ".local/share/themes/FlatColor" = {
      recursive = true;
      source = pkgs.stdenv.mkDerivation {
        name = "FlatColor";

        src = pkgs.fetchFromGitHub {
          owner = "jasperro";
          repo = "FlatColor";
          rev = "0a56c50e8c5e2ad35f6174c19a00e01b30874074";
          hash = "sha256-P8RnYTk9Z1rCBEEMLTVRrNr5tUM/Pc9dsdMtpHd1Y18=";
        };

        buildPhase = ''
          mkdir -p $out
          # delete the default gtk-color-scheme:
          file="./gtk-2.0/gtkrc"
          sed -i '3,29d' $file
          sed -i '3i include "../colors2"' $file

          file="./gtk-3.0/gtk.css"
          sed -i '2,10d' $file
          sed -i '2i @import url("../colors3");' $file

          file="./gtk-3.20/gtk.css"
          sed -i '2,26d' $file
          sed -i '2i @import url("../colors3");' $file

          cp -r . $out
        '';
      };
    };

    ".local/share/themes/FlatColor/colors2".text = ''
      bg_color:#${config.var.theme.colors.background}
      color0:#1e1e2e
      color1:#f38ba8
      color2:#a6e3a1
      color3:#fab387
      color4:#89b4fa
      color5:#A594FD
      color6:#74c7ec
      color7:#cdd6f4
      color8:#313244
      color9:#eba0ac
      color10:#94e2d5
      color11:#f9e2af
      color12:#b4befe
      color13:#f5c2e7
      color14:#94e2d5
      color15:#bac2de
      text_color:#${config.var.theme.colors.text}
      selected_bg_color:#${config.var.theme.colors.accent}
      selected_fg_color:#${config.var.theme.colors.background}
      tooltip_bg_color:#${config.var.theme.colors.background_alternative}
      tooltip_fg_color:#${config.var.theme.colors.text}
      titlebar_bg_color:#${config.var.theme.colors.background_alternative}
      titlebar_fg_color:#${config.var.theme.colors.text}
      menu_bg_color:#${config.var.theme.colors.background_alternative}
      menu_fg_color:#${config.var.theme.colors.text}
      link_color:#${config.var.theme.colors.accent}
    '';

    ".local/share/themes/FlatColor/colors3".text = ''
      @define-color color0 #1e1e2e;
      @define-color color1 #f38ba8;
      @define-color color2 #a6e3a1;
      @define-color color3 #fab387;
      @define-color color4 #89b4fa;
      @define-color color5 #A594FD;
      @define-color color6 #74c7ec;
      @define-color color7 #cdd6f4;
      @define-color color8 #313244;
      @define-color color9 #eba0ac;
      @define-color color10 #94e2d5;
      @define-color color11 #f9e2af;
      @define-color color12 #b4befe;
      @define-color color13 #f5c2e7;
      @define-color color14 #94e2d5;
      @define-color color15 #bac2de;
      @define-color selected_bg_color #${config.var.theme.colors.accent};
      @define-color selected_fg_color #${config.var.theme.colors.background};

      @define-color bg_color #${config.var.theme.colors.background};
      @define-color fg_color #${config.var.theme.colors.text};
      @define-color base_color @bg_color;
      @define-color text_color @fg_color;
      @define-color text_color_disabled mix(@text_color, @base_color, 0.4);
      @define-color tooltip_bg_color #${config.var.theme.colors.background_alternative};
      @define-color tooltip_fg_color #${config.var.theme.colors.text};
    '';
  };
}
