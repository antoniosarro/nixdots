{
  pkgs,
  config,
  ...
}: let
  appmenu = pkgs.writeShellScriptBin "appmenu" ''
    rofi -show drun -theme ${config.home.homeDirectory}/.config/rofi/launcher.rasi
  '';
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    # Uptime
    s=$(< /proc/uptime)
    d="$((s / 60 / 60 / 24)) days"
    h="$((s / 60 / 60 % 24)) hours"
    m="$((s / 60 % 60)) minutes"
    # Remove plural if < 2.
    ((''${d/ *} == 1)) && d=''${d/s}
    ((''${h/ *} == 1)) && h=''${h/s}
    ((''${m/ *} == 1)) && m=''${m/s}
    # Hide empty fields.
    ((''${d/ *} == 0)) && unset d
    ((''${h/ *} == 0)) && unset h
    ((''${m/ *} == 0)) && unset m
    uptime=''${d:+$d, }''${h:+$h, }$m
    uptime=''${uptime%', '}
    uptime=''${uptime:-$s seconds}


    # Options
    shutdown='󰐥'
    reboot='󰑓'
    lock=''
    suspend=''
    logout='󰍃'
    yes='Y'
    no='N'

    # Rofi CMD
    rofi_cmd() {
      rofi -dmenu \
        -p "Uptime: $uptime" \
        -mesg "Uptime: $uptime" \
        -theme "${config.home.homeDirectory}/.config/rofi/powermenu.rasi"
    }

    # Pass variables to rofi dmenu
    run_rofi() {
      echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
    }

    # Actions
    chosen=$(run_rofi)
    case $chosen in
        "$shutdown")
        sleep 1; systemctl poweroff;
            ;;
        "$reboot")
        sleep 1; systemctl reboot;
            ;;
        "$lock")
        sleep 1; ${pkgs.hyprlock}/bin/hyprlock;
            ;;
        "$suspend")
        sleep 1; systemctl suspend;
            ;;
        "$logout")
        echo ""
            ;;
    esac
  '';
in {home.packages = [appmenu powermenu];}
