function cdo {
	for h in snap crackle pop; do
		echo ========= "${h}" ========
		ssh "${h}" "${@}"
	done
}
