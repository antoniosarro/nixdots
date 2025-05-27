{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "builtin";
        height = 15;
        width = 30;
        padding = {
          top = 5;
          left = 3;
        };
      };
      modules = [
        { type = "break"; }
        {
          type = "custom";
          format = "{#30}┌──────────────────────Hardware──────────────────────┐";
        }
        {
          type = "custom";
          format = "{#32} PC: {#39}Desktop";
        }
        {
          type = "cpu";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "gpu";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "disk";
          key = "│ ├";
          keyColor = "green";
        }
        {
          type = "custom";
          format = "{#30}└────────────────────────────────────────────────────┘";
        }
        { type = "break"; }
        {
          type = "custom";
          format = "{#30}┌──────────────────────Software──────────────────────┐";
        }
        {
          type = "os";
          key = " OS";
          keyColor = "yellow";
        }
        {
          type = "kernel";
          key = "│ ├";
          keyColor = "yellow";
        }
        {
          type = "bios";
          key = "│ ├";
          keyColor = "yellow";
        }
        {
          type = "packages";
          key = "│ ├󰏖";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "└ └";
          keyColor = "yellow";
        }
        { type = "break"; }
        {
          type = "wm";
          key = " WM";
          keyColor = "blue";
        }
        {
          type = "lm";
          key = "│ ├";
          keyColor = "blue";
        }
        {
          type = "terminal";
          key = "└ └";
          keyColor = "blue";
        }
        {
          type = "custom";
          format = "{#30}└────────────────────────────────────────────────────┘";
        }
        { type = "break"; }
        {
          type = "custom";
          format = "{#30}┌────────────────────Uptime / Age / DT────────────────────┐";
        }
        {
          type = "command";
          key = "  OS Age ";
          keyColor = "magenta";
          text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
        }
        {
          type = "uptime";
          key = "  Uptime ";
          keyColor = "magenta";
        }
        {
          type = "datetime";
          key = "  Date ";
          keyColor = "magenta";
        }
        {
          type = "custom";
          format = "{#30}└─────────────────────────────────────────────────────────┘";
        }
        { type = "break"; }
      ];
    };
  };
}
