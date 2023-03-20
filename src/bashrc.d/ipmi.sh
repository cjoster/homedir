function ipmi {
	[ "${#@}" -ge 2 ] || { >&2 echo "At least two arguments expected."; return 1; }
	local h="${1}"; shift;
	ipmitool -I lanplus -U cjo -H "${h}-ipmi" -C 3 "${@}"
}
