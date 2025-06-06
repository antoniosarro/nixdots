{
  pkgs,
  config,
  ...
}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      vesktop
      ;
  };

  home.file."${config.home.homeDirectory}/.config/vesktop/themes/base16.css" = {
    force = true;
    text = ''
      :root {
         --base00: #${config.hostSpec.theme.colors.base00};
         --base01: #${config.hostSpec.theme.colors.base01};
         --base02: #${config.hostSpec.theme.colors.base02};
         --base03: #${config.hostSpec.theme.colors.base03};
         --base04: #${config.hostSpec.theme.colors.base04};
         --base05: #${config.hostSpec.theme.colors.base05};
         --base06: #${config.hostSpec.theme.colors.base06};
         --base07: #${config.hostSpec.theme.colors.base07};
         --base08: #${config.hostSpec.theme.colors.base08};
         --base09: #${config.hostSpec.theme.colors.base09};
         --base0A: #${config.hostSpec.theme.colors.base0A};
         --base0B: #${config.hostSpec.theme.colors.base0B};
         --base0C: #${config.hostSpec.theme.colors.base0C};
         --base0D: #${config.hostSpec.theme.colors.base0D};
         --base0E: #${config.hostSpec.theme.colors.base0E};
         --base0F: #${config.hostSpec.theme.colors.base0F};

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
}
