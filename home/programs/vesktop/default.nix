{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      vesktop
    ];
    file.".config/vesktop/themes/base16.css" = {
      force = true;
      text = ''
         :root {
            --base00: ${config.var.theme.colors.base00};
            --base01: ${config.var.theme.colors.base01};
            --base02: #2f3549;
            --base03: ${config.var.theme.colors.base03};
            --base04: #787c99;
            --base05: ${config.var.theme.colors.base05};
            --base06: #cbccd1;
            --base07: #d5d6db;
            --base08: #c0caf5;
            --base09: #a9b1d6;
            --base0A: ${config.var.theme.colors.base0A};
            --base0B: #9ece6a;
            --base0C: ${config.var.theme.colors.base0C};
            --base0D: #2ac3de;
            --base0E: #bb9af7;
            --base0F: #f7768e;

            --primary-630: var(--base00); /* Autocomplete background */
            --primary-660: var(--base00); /* Search input background */
        }


        .theme-light, .theme-dark {
            --search-popout-option-fade: none; /* Disable fade for search popout */
            --bg-overlay-2: var(--base00); /* These 2 are needed for proper threads coloring */
            --home-background: var(--base00);
            --background-primary: var(--base00);
            --background-secondary: var(--base01);
            --background-secondary-alt: var(--base01);
            --channeltextarea-background: var(--base01);
            --background-tertiary: var(--base00);
            --background-accent: var(--base0E);
            --background-floating: var(--base01);
            --background-modifier-selected: var(--base00);
            --text-normal: var(--base05);
            --text-secondary: var(--base00);
            --text-muted: var(--base03);
            --text-link: var(--base0C);
            --interactive-normal: var(--base05);
            --interactive-hover: var(--base0C);
            --interactive-active: var(--base0A);
            --interactive-muted: var(--base03);
            --header-primary: var(--base06);
            --header-secondary: var(--base03);
            --scrollbar-thin-track: transparent;
            --scrollbar-auto-track: transparent;
        }
      '';
    };
  };
}
