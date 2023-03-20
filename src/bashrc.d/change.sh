rcfiles=".bashrc .bash_profile .bash_custom .profile"
lasthash=""

_list_rcfiles() {
	local i=0
	local out=""
	for i in ${rcfiles}; do
		[ -r "${HOME}/${i}" ] && { [ -n "${out:-}" ] && out="${out} ${HOME}/${i}" || out="${HOME}/${i}"; }
	done
	[ -z "${out}" ] || echo "${out} $([ ! -d "${HOME}/.bashrc.d" ] || find "${HOME}/.bashrc.d" -name \*.sh -type f | tr '\n' ' ' | sed 's/[[:space:]]*$/\n/')"
}

prompt_cmd() {
	echo "${-}" | grep i > /dev/null 2>&1 || return
	local rcfiles="$(_list_rcfiles)"
	[ -n "${rcfiles}" ] || return 
	if mkdir -p "$(dirname "${lasthash_file}")"; then
		newsum="$(sha256sum ${rcfiles} | sort | sha256sum | cut -d\  -f 1)"
		if [ -z "${lasthash}" ]; then # we are being sourced, doin't do anything
			lasthash="${newsum}"
		elif [ "${newsum}" != "${lasthash}" ]; then
			local serr=""
			for f in ${rcfiles}; do
				bash -n "${f}" > /dev/null 2>&1 || { [ -n "${serr}" ] && serr="${serr} ${f}" || serr="${f}"; }
			done
			if [ -n "${serr}" ]; then
				>&2 echo "WARNING: You have syntax errors in the following RC files: ${serr}. Not sourcing RC files."
			else
				>&2 echo "Bash RC files has changed. Resourcing..."
				. "${HOME}/.bashrc" || { >&2 echo "Error sourcing .bashrc"; return; }
				lasthash="${newsum}"
			fi
		fi
	fi	
}

export PROMPT_CMD=prompt_cmd

