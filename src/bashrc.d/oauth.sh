alias authkey='oathtool --hotp $(gpg2 -qd ~/.oath/key) -c $([ ! -f ~/.oath/counter ] && echo -n 0 > ~/.oath/counter || echo -n $(($(cat ~/.oath/counter)+1)) > ~/.oath/counter; cat ~/.oath/counter)'
alias pinauth='[ ! -r ~/.oath/pin ] && echo "No PIN stored." || echo "$(cat ~/.oath/pin)$(authkey)"' 
