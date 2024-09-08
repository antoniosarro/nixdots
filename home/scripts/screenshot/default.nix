{
  pkgs,
  config,
  ...
}: let
  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    # Theme Elements
    prompt='Screenshot'
    dir="${config.var.homeDirectory}/Pictures/Screenshots"
    mesg="DIR: $dir"

    # Options
    option_1="󰍹  Capture Desktop"
    option_2="  Capture Area"
    option_3="  Capture Area (Freeze)"

    # Rofi CMD
    rofi_cmd() {
      rofi -theme-str "window {width: 400px;}" \
        -theme-str "listview {columns: 1; lines: 3;}" \
        -theme-str 'textbox-prompt-colon {str: " ";}' \
        -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -markup-rows \
        -theme "~/.config/rofi/screenshot.rasi"
    }

    # Pass variables to rofi dmenu
    run_rofi() {
      echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
    }

    # Screenshot
    time=$(date +%Y-%m-%d-%H-%M-%S)
    file="Screenshot_$time.png"

    # Execute Command
    run_cmd() {
      if [[ "$1" == '--opt1' ]]; then
        sleep 1 && grimblast copysave screen "$dir/$file" && swappy -f "$dir/$file"
      elif [[ "$1" == '--opt2' ]]; then
        sleep 1 && grimblast copysave area "$dir/$file" && swappy -f "$dir/$file"
      elif [[ "$1" == '--opt3' ]]; then
        sleep 1 && grimblast --freeze copysave area "$dir/$file" && swappy -f "$dir/$file"
      fi
    }

    # Actions
    chosen="$(run_rofi)"
    case $chosen in
        "$option_1")
        run_cmd --opt1
            ;;
        "$option_2")
        run_cmd --opt2
            ;;
        "$option_3")
        run_cmd --opt3
            ;;
    esac
  '';
in {
  home.packages = with pkgs; [
    screenshot
  ];
}
