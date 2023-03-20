[ -d ~/.config ] || mkdir ~/.config 

SHA="$(sha512sum ~/.bashrc | cut -d\  -f 1)"
FAILED_SHA=0

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

alias morning='echo -n "$(greeting) "; [ -r ~/.config/todo ] && { { echo "Your TODO list is:"; echo; cat ~/.config/todo | grep -Ev "^[[:space:]]*\$" | cat -n | sed "s/\$/\\n/"; } || true; } || echo "You have nothing on your todo list."'


function prompt_cmd {

        echo $- | grep i > /dev/null 2>&1 || return;

        local mySHA="$(sha512sum ~/.bashrc | cut -d\  -f 1)"
        if [ "${SHA}" != "${mySHA}" ]; then
                if [ "${FAILED_SHA}" == "${mySHA}" ]; then
                        echo "WARNING: There are syntax errors in your .bashrc"
                else
                        echo "WARNING: .bashrc has changed "
                        if bash -n ~/.bashrc; then
                                echo "re-sourcing ~/.bashrc"
                                . ~/.bashrc
                        else
                                echo "~/.bashrc fails linting. Not reloading"
                                FAILED_SHA="${mySHA}"
                        fi
                fi
        fi

        if [ ! -r ~/.config/last_cmd_prompt ] || [ "$(($(date +%s)-$(stat -c %Z ~/.config/last_cmd_prompt)))" -ge "3600" ]; then
                morning
        fi

        touch ~/.config/last_cmd_prompt
}

export PROMPT_COMMAND=prompt_cmd
