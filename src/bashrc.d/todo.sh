[ -d ~/.config ] || mkdir ~/.config 

function greeting {
        local hour="$(date +%H | sed 's/^0//')"

        if [ "${hour}" -ge "4" -a "${hour}" -lt "12" ]; then
                echo "Good morning."
        elif [ "${hour}" -ge "12" -a "${hour}" -lt "16" ]; then
                echo "Good afternoon."
        elif [ "${hour}" -ge "16" -a "${hour}" -lt "20" ]; then
                echo "Good evening."
        elif [ "${hour}" -ge "20" -a "${hour}" -le "24" ]; then
                echo "Hello."
        else
                echo "It's late."
        fi
}

function morning {
	echo -n "$(greeting) "
	if [ -r ~/.config/todo ]; then
		echo "Your TODO list is:"
		echo
		cat ~/.config/todo | grep -Ev "^[[:space:]]*\$" | cat -n | sed "s/\$/\\n/"
	else
		echo "You have nothing on your todo list."
	fi
}

alias todo='[ ! -d ~/.config ] && mkdir ~/.config; vim ~/.config/todo'
