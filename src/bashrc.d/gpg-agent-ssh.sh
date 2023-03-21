export GPG_TTY=$(tty)
str="$(gpg-agent --daemon --enable-ssh-support 2>/dev/null)"
if [ ! -z "${str}" ]; then
	echo "${str}" > ~/.gpg-agent-settings
	eval $str
else
	eval $(cat ~/.gpg-agent-settings)
fi
