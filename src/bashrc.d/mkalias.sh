# Sudo aliases
function is_alias {										 
	[ -z "$(alias | grep -E "^alias[[:space:]]+${1}=")" ] && return 1 || return 0														   
}																								       
																									
function get_alias {																						    
	alias | grep --color=auto -E "^alias[[:space:]]+${1}=" | sed "s/^alias[[:space:]]\+${1}='\(.*\)'[[:space:]]*$/\1/"									      
}

function mkalias {
	for f in ${*}; do
		is_alias ${f}
		if [ $? -eq 0 ]; then
			a="$(get_alias ${f})"
			if [ -z "$(echo "${a}" | grep -E ^sudo)" ]; then
				alias ${f}="sudo ${a}"
			fi
		else
			alias ${f}="sudo ${f}"
		fi
	done
}

if [ $(type -P dnf) ]; then
  alias yum=dnf
else
  alias dnf=yum
fi

mkalias virsh yum dnf

function _systemctl {
	local user=0
	for f in "$@"; do
		if [ "${f}" == "--user" ]; then
			user=1
			continue
		fi
	done

	local sudo=""
	[ "${user}" ] || sudo="sudo"
	$sudo systemctl "${@}"
}

alias systemctl=_systemctl
