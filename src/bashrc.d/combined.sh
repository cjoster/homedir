[ -n "$(pactl list short sinks | awk '$2=="combined"{print $1}')" ] || pactl load-module module-combine-sink > /dev/null 2>&1; [ -n "$(pactl list short sinks | awk '$2=="combined"{print $1}')" ] && pactl set-default-sink combined  || { >&2 echo "Error, cannot create combined output sink."; }
