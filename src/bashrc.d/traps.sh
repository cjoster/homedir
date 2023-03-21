alias traps='trap -l|sed "s,\t,\n,g;s,),:,g;s,SIG,,g;s, \([0-9]\),\1,g" | grep -Ev ^[[:space:]]*\$'
