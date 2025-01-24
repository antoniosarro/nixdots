{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    extraConfig = {
      show-icons = true;
      drun-match-fields = "name";
      drun-display-format = "{name}";
    };
  };

  home.file."${config.home.homeDirectory}/.config/rofi/theme.rasi" = {
    force = true;
    text = ''
      * {
        background:     #${config.hostSpec.theme.colors.base00};
        background-alt: #${config.hostSpec.theme.colors.base02};
        foreground:     #${config.hostSpec.theme.colors.base0D};
        selected:       #${config.hostSpec.theme.colors.base0D};
        active:         #${config.hostSpec.theme.colors.base0B};
        urgent:         #${config.hostSpec.theme.colors.base08};
      }
    '';
  };

  home.file.".config/rofi/launcher.rasi" = {
    force = true;
    text = ''
      configuration {
        modi:                       "drun";
        show-icons:                 true;
        display-drun:               " Apps";
        drun-display-format:        "{name}";
        font:                        "${config.hostSpec.theme.font.base} 10";
        window-format:              "{w} · {c} · {t}";
      }

      @theme "~/.config/rofi/theme.rasi"

      /*****----- Global Properties -----*****/
      * {
          border-colour:               var(selected);
          handle-colour:               var(selected);
          background-colour:           var(background);
          foreground-colour:           var(foreground);
          alternate-background:        var(background-alt);
          normal-background:           var(background);
          normal-foreground:           var(foreground);
          urgent-background:           var(urgent);
          urgent-foreground:           var(background);
          active-background:           var(active);
          active-foreground:           var(background);
          selected-normal-background:  var(selected);
          selected-normal-foreground:  var(background);
          selected-urgent-background:  var(active);
          selected-urgent-foreground:  var(background);
          selected-active-background:  var(urgent);
          selected-active-foreground:  var(background);
          alternate-normal-background: var(background);
          alternate-normal-foreground: var(foreground);
          alternate-urgent-background: var(urgent);
          alternate-urgent-foreground: var(background);
          alternate-active-background: var(active);
          alternate-active-foreground: var(background);
      }

      /*****----- Main Window -----*****/
      window {
          /* properties for window widget */
          transparency:                "real";
          location:                    center;
          anchor:                      center;
          fullscreen:                  false;
          width:                       800px;
          x-offset:                    0px;
          y-offset:                    0px;

          /* properties for all widgets */
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      1px solid;
          border-radius:               10px;
          border-color:                @border-colour;
          cursor:                      "default";
          /* Backgroud Colors */
          background-color:            @background-colour;
      }

      /*****----- Main Box -----*****/
      mainbox {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     20px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          children:                    [ "inputbar", "mode-switcher", "message", "listview" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          children:                    [ "textbox-prompt-colon", "entry" ];
      }

      prompt {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
      }
      textbox-prompt-colon {
          enabled:                     true;
          padding:                     5px 0px;
          expand:                      false;
          str:                         "";
          background-color:            inherit;
          text-color:                  inherit;
      }
      entry {
          enabled:                     true;
          padding:                     5px 0px;
          background-color:            inherit;
          text-color:                  inherit;
          cursor:                      text;
          placeholder:                 "Search...";
          placeholder-color:           inherit;
      }
      num-filtered-rows {
          enabled:                     true;
          expand:                      false;
          background-color:            inherit;
          text-color:                  inherit;
      }
      textbox-num-sep {
          enabled:                     true;
          expand:                      false;
          str:                         "/";
          background-color:            inherit;
          text-color:                  inherit;
      }
      num-rows {
          enabled:                     true;
          expand:                      false;
          background-color:            inherit;
          text-color:                  inherit;
      }
      case-indicator {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
      }

      /*****----- Listview -----*****/
      listview {
          enabled:                     true;
          columns:                     1;
          lines:                       8;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   false;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;

          spacing:                     5px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      "default";
      }
      scrollbar {
          handle-width:                5px ;
          handle-color:                @handle-colour;
          border-radius:               10px;
          background-color:            @alternate-background;
      }

      /*****----- Elements -----*****/
      element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     10px;
          border:                      0px solid;
          border-radius:               8px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          expand:                      false;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     12px;
          border:                      0px solid;
          border-radius:               8px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     12px;
          border:                      0px solid;
          border-radius:               8px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     0px;
          border:                      2px solid;
          border-radius:               8px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
  };

  home.file.".config/rofi/powermenu.rasi" = {
    force = true;
    text = ''
      configuration {
          show-icons:                 false;
      }

      /*****----- Global Properties -----*****/
      @theme "~/.config/rofi/theme.rasi"

      /*
      USE_BUTTONS=YES
      */

      /*****----- Main Window -----*****/
      window {
          /* properties for window widget */
          transparency:                "real";
          location:                    center;
          anchor:                      center;
          fullscreen:                  false;
          width:                       800px;
          x-offset:                    0px;
          y-offset:                    0px;

          /* properties for all widgets */
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      1px solid;
          border-radius:               20px;
          border-color:                @selected;
          cursor:                      "default";
          background-color:            @background;
      }

      /*****----- Main Box -----*****/
      mainbox {
          enabled:                     true;
          spacing:                     15px;
          margin:                      0px;
          padding:                     30px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          children:                    [ "inputbar", "listview" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
          enabled:                     true;
          spacing:                     15px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          text-color:                  @foreground;
          children:                    [ "textbox-prompt-colon", "prompt"];
      }

      dummy {
          background-color:            transparent;
      }

      textbox-prompt-colon {
          enabled:                     true;
          expand:                      false;
          str:                         "󰐥";
          padding:                     12px 18px;
          border-radius:               100%;
          background-color:            @urgent;
          text-color:                  @background;
      }

      prompt {
          enabled:                     true;
          padding:                     12px;
          border-radius:               100%;
          background-color:            @active;
          text-color:                  @background;
          font:                        "${config.hostSpec.theme.font.base} 10";
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     12px;
          border:                      0px solid;
          border-radius:               100%;
          border-color:                @selected;
          background-color:            @background-alt;
          text-color:                  @foreground;
      }
      textbox {
          background-color:            inherit;
          text-color:                  inherit;
          vertical-align:              0.5;
          horizontal-align:            0.5;
          placeholder-color:           @foreground;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     12px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            @background;
          text-color:                  @foreground;
      }

      /*****----- Listview -----*****/
      listview {
          enabled:                     true;
          columns:                     5;
          lines:                       1;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   false;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;

          spacing:                     15px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          text-color:                  @foreground;
          cursor:                      "default";
      }

      /*****----- Elements -----*****/
      element {
          enabled:                     true;
          spacing:                     0px;
          margin:                      0px;
          padding:                     20px 10px;
          border:                      1px solid;
          border-radius:               100%;
          border-color:                @selected;
          background-color:            @background-alt;
          text-color:                  @foreground;
          cursor:                      pointer;
      }
      element-text {
          font:                        "${config.hostSpec.theme.font.base} 20";
          background-color:            transparent;
          text-color:                  inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.47;
      }
      element selected.normal {
          background-color:            var(selected);
          text-color:                  var(background);
      }
    '';
  };
}
