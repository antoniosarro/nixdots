{
  pkgs,
  config,
  ...
}: let
  appmenu = pkgs.writeShellScriptBin "appmenu" ''
    if pgrep rofi; then
      pkill rofi
    else
      rofi -show drun -theme ${config.var.homeDirectory}/.config/rofi/launcher.rasi
    fi
  '';
  powermenu = pkgs.writeShellScriptBin "powermenu" ''
    # CMDs
    uptime=$(uptime -p | sed -e 's/up //g')

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
        -theme "~/.config/rofi/powermenu.rasi"
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
