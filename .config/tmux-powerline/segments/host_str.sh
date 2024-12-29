# shellcheck shell=bash
# print tmux

generate_segmentrc() {
	read -r -d '' rccontents <<EORC
# prints devdesk
EORC
	echo "$rccontents"
}

run_segment() {
	echo "mac"
	return 0
}
