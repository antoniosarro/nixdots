let
  colors = import ../../colors.nix {};
in {
  programs.nixvim = {
    plugins.alpha = let
      nixFlake = [
        "                                                               "
        "                                                               "
        "             ███                           ███                 "
        "            ░░░                           ░░░                  "
        " ████████   ████  █████ █████ █████ █████ ████  █████████████  "
        "░░███░░███ ░░███ ░░███ ░░███ ░░███ ░░███ ░░███ ░░███░░███░░███ "
        " ░███ ░███  ░███  ░░░█████░   ░███  ░███  ░███  ░███ ░███ ░███ "
        " ░███ ░███  ░███   ███░░░███  ░░███ ███   ░███  ░███ ░███ ░███ "
        " ████ █████ █████ █████ █████  ░░█████    █████ █████░███ █████"
        "░░░░ ░░░░░ ░░░░░ ░░░░░ ░░░░░    ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░ "
        "                                                               "
        "                                                               "
        "                                                               "
        "                                                               "
        "                                                               "
        "                  git@github.com:antoniosarro                  "
      ];
    in {
      enable = true;
      layout = [
        {
          type = "padding";
          val = 4;
        }
        {
          opts = {
            hl = "AlphaHeader";
            position = "center";
          };
          type = "text";
          val = nixFlake;
        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          val = let
            mkButton = shortcut: cmd: val: hl: {
              type = "button";
              inherit val;
              opts = {
                inherit hl shortcut;
                keymap = [
                  "n"
                  shortcut
                  cmd
                  {}
                ];
                position = "center";
                cursor = 0;
                width = 40;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            };
          in [
            (
              mkButton "f" "<CMD>lua require('telescope.builtin').find_files({ hidden = true })<CR>"
              "󰍉 Find File"
              "Operator"
            )
            (mkButton "g" "<CMD>LazyGit<CR>" " Open LazyGit" "Constant")
            (mkButton "q" "<CMD>qa<CR>" "󰚑 Quit Neovim" "String")
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "AlphaFooter";
            position = "center";
          };
          type = "text";
          val = "🐂";
        }
      ];
    };
    highlight = {
      AlphaHeader = {
        fg = "${colors.base0D}";
      };
      AlphaFooter = {
        fg = "${colors.base0F}";
      };
    };
  };
}
