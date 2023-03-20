alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0  | grep --color=never -E "(state)|(percentage)|(time to)"  | sed "s/^[[:space:]]*//; s/\:[[:space:]]*/: /"'
