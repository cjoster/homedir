#!/usr/bin/env bash

set -euo pipefail

if [ "${1:-}" == "get" ] && [ "${2:-}" == "ev" ] || [ "${2:-}" == "events" ]; then
	kubectl "${@}" --sort-by=.lastTimestamp
else
	kubectl "${@}"
fi
