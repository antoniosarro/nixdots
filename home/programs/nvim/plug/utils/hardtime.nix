{
  programs.nixvim.plugins.hardtime = {
    enable = true;
    settings = {
      hint = true;
      max_time = 1000;
      max_count = 4;
      disable_mouse = true;
      restriction_maode = "hint";
      restricted_keys = {
        "h" = [
          "n"
          "x"
        ];
        "j" = [
          "n"
          "x"
        ];
        "k" = [
          "n"
          "x"
        ];
        "l" = [
          "n"
          "x"
        ];
        "-" = [
          "n"
          "x"
        ];
        "+" = [
          "n"
          "x"
        ];
        "gj" = [
          "n"
          "x"
        ];
        "gk" = [
          "n"
          "x"
        ];
        "<CR>" = [
          "n"
          "x"
        ];
        "<C-M>" = [
          "n"
          "x"
        ];
        "<C-N>" = [
          "n"
          "x"
        ];
        "<C-P>" = [
          "n"
          "x"
        ];
      };
    };
  };
}
