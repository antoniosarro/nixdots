{
  pkgs,
  config,
  ...
}: let
  sound-change = pkgs.writeShellScriptBin "sound-change" ''
    sleep 0.05

    [[ $1 == "mute" ]] && wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    [[ $1 == "up" ]] && wpctl set-volume @DEFAULT_AUDIO_SINK@ "5%+"
    [[ $1 == "down" ]] && wpctl set-volume @DEFAULT_AUDIO_SINK@ "5%-"

    sink_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

    volume=$(echo "$sink_info" | awk '{print $2}' | sed 's/%//' | awk '{print $1 * 100}')
    muted=false
    if [[ $sink_info == *"MUTED"* ]]; then
      muted=true
    fi

    message=""
    if [ $muted = true ]; then
      message="󰖁 Muted"
    else
      message="󰕾 Volume: $volume%"
    fi

    notif "sound" "$message" "extraargs=-h int:value:$volume"
  '';

  sound-up = pkgs.writeShellScriptBin "sound-up" ''
    sound-change up
  '';

  sound-down = pkgs.writeShellScriptBin "sound-down" ''
    sound-change down
  '';

  sound-toggle = pkgs.writeShellScriptBin "sound-toggle" ''
    sound-change mute
  '';
in {
  home.packages = [sound-change sound-up sound-down sound-toggle];
}
